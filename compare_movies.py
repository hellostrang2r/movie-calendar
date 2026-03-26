import json
from pathlib import Path

OLD_FILE = Path("data/movies.json")
NEW_FILE = Path("new_movies.json")
MERGED_FILE = Path("merged_movies.json")


def load_json(path: Path):
    if not path.exists():
        return []
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def movie_key(movie):
    return movie.get("movieCd", "")


def is_same_movie_data(old, new):
    fields = [
        "movieNm",
        "openDt",
        "genreNm",
        "nationAlt",
        "director",
        "isReRelease",
    ]
    return all(old.get(field) == new.get(field) for field in fields)


def main():
    old_movies = load_json(OLD_FILE)
    new_movies = load_json(NEW_FILE)

    old_map = {movie_key(m): m for m in old_movies if movie_key(m)}
    new_map = {movie_key(m): m for m in new_movies if movie_key(m)}

    added = []
    updated = []
    unchanged = []
    removed = []

    # 새 목록 기준 비교
    for movie_cd, new_movie in new_map.items():
        old_movie = old_map.get(movie_cd)

        if old_movie is None:
            added.append(new_movie)
        else:
            if is_same_movie_data(old_movie, new_movie):
                unchanged.append(new_movie)
            else:
                updated.append({
                    "movieCd": movie_cd,
                    "old": old_movie,
                    "new": new_movie,
                })

    # 기존에만 있고 새 목록에는 없는 것
    for movie_cd, old_movie in old_map.items():
        if movie_cd not in new_map:
            removed.append(old_movie)

    # 최종 병합본:
    # 새 목록을 기준으로 사용
    merged = list(new_map.values())
    merged.sort(key=lambda x: (x.get("openDt", ""), x.get("movieNm", "")))

    with open(MERGED_FILE, "w", encoding="utf-8") as f:
        json.dump(merged, f, ensure_ascii=False, indent=2)

    print("\n=== 비교 결과 ===")
    print(f"기존 개수: {len(old_movies)}")
    print(f"새 추출 개수: {len(new_movies)}")
    print(f"추가됨: {len(added)}")
    print(f"변경됨: {len(updated)}")
    print(f"유지됨: {len(unchanged)}")
    print(f"빠짐(기존에만 있음): {len(removed)}")

    if added:
        print("\n[추가된 영화]")
        for movie in added[:20]:
            print(f"- {movie.get('movieNm')} ({movie.get('openDt')})")

    if updated:
        print("\n[변경된 영화]")
        for item in updated[:20]:
            print(f"- {item['new'].get('movieNm')} ({item['new'].get('openDt')})")

    if removed:
        print("\n[빠진 영화]")
        for movie in removed[:20]:
            print(f"- {movie.get('movieNm')} ({movie.get('openDt')})")

    print(f"\n병합 결과 저장 완료: {MERGED_FILE}")


if __name__ == "__main__":
    main()