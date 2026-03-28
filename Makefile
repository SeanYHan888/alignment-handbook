.PHONY: style quality

# make sure to test the local checkout in scripts and not the pre-installed one (don't use quotes!)
export PYTHONPATH = src

check_dirs := src tests scripts

style:
	uv run black $(check_dirs)
	uv run isort $(check_dirs)

quality:
	uv run black --check $(check_dirs)
	uv run isort --check-only $(check_dirs)
	uv run flake8 $(check_dirs)


# Release stuff

pre-release:
	uv run python src/alignment/release.py

pre-patch:
	uv run python src/alignment/release.py --patch

post-release:
	uv run python src/alignment/release.py --post_release

post-patch:
	uv run python src/alignment/release.py --post_release --patch

wheels:
	uv build

wheels_clean:
	rm -rf alignment.egg-info build dist src/alignment_handbook.egg-info

pypi_upload:
	uv publish

pypi_test_upload:
	uv publish --index testpypi
