import unittest

import update_movies


def movie(movie_cd, status=None):
    data = {
        "movieCd": movie_cd,
        "movieNm": f"Movie {movie_cd}",
        "openDt": "2026-05-01",
        "genreNm": "드라마",
        "nationAlt": "한국",
        "director": "감독",
        "isReRelease": False,
        "overview": "줄거리",
    }
    if status is not None:
        data["status"] = status
    return data


class StatusTransitionTest(unittest.TestCase):
    def test_split_movies_by_status_honors_explicit_status(self):
        buckets = update_movies.split_movies_by_status(
            [
                movie("saved"),
                movie("held", update_movies.STATUS_HELD),
                movie("excluded", update_movies.STATUS_EXCLUDED),
            ],
            update_movies.STATUS_SAVED,
        )

        self.assertEqual(["saved"], [item["movieCd"] for item in buckets.saved])
        self.assertEqual(["held"], [item["movieCd"] for item in buckets.held])
        self.assertEqual(
            ["excluded"],
            [item["movieCd"] for item in buckets.excluded],
        )

    def test_status_transition_moves_released_held_movie_to_manual_saved(self):
        buckets, manual_movies = update_movies.apply_status_transitions(
            current_movies=[],
            manual_movies=[],
            held_movies=[movie("released", update_movies.STATUS_SAVED)],
            excluded_movies=[],
        )

        self.assertEqual([], buckets.held)
        self.assertEqual(["released"], [item["movieCd"] for item in manual_movies])

    def test_dedupe_prefers_excluded_then_held_then_manual(self):
        buckets = update_movies.dedupe_status_buckets(
            manual_movies=[movie("manual_only"), movie("held_wins"), movie("excluded_wins")],
            held_movies=[
                movie("held_wins", update_movies.STATUS_HELD),
                movie("excluded_wins", update_movies.STATUS_HELD),
            ],
            excluded_movies=[movie("excluded_wins", update_movies.STATUS_EXCLUDED)],
        )

        self.assertEqual(["manual_only"], [item["movieCd"] for item in buckets.saved])
        self.assertEqual(["held_wins"], [item["movieCd"] for item in buckets.held])
        self.assertEqual(
            ["excluded_wins"],
            [item["movieCd"] for item in buckets.excluded],
        )

    def test_force_default_status_overrides_stale_status_in_file_bucket(self):
        normalized = update_movies.normalize_movies_for_status(
            [movie("stale", update_movies.STATUS_SAVED)],
            update_movies.STATUS_HELD,
            force_default_status=True,
        )

        self.assertEqual(update_movies.STATUS_HELD, normalized[0]["status"])

    def test_manual_saved_movie_is_not_extracted_to_held(self):
        current_map = {"manual_saved": movie("manual_saved")}

        held_movies = update_movies.extract_held_movies_from_current_map(
            current_map,
            held_movies=[],
            force_saved_ids={"manual_saved"},
        )

        self.assertEqual([], held_movies)
        self.assertIn("manual_saved", current_map)


if __name__ == "__main__":
    unittest.main()
