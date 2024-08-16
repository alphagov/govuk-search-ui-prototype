web: bundle exec rails server -p $PORT

# When pointing the `govuk_publishing_components` gem to a Git branch, the source is missing the
# `node_modules` that would normally be built as part of the gem release. This forces them to be
# installed.
release: yarn run fix-gpc-from-source
