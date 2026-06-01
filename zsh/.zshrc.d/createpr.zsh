createpr () { 
  url=$(git remote get-url origin)
  url=${url%.git}

  # Strip prefix to get owner/repo
  repo=${url#git@github.com:}
  repo=${repo#https://github.com/:}
  repo=${repo#ssh://github.com/:}

  bkmk=$(jj log -r 'heads(::@- & bookmarks())' --no-graph -T 'bookmarks')
  [ -z "$bkmk" ] && { echo "No bookmark found" >&2; return 1; }

  open "https://github.com/$repo/compare/$bkmk" 
}
