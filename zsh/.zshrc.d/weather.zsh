weather () {
    if [[ -z $1 ]]
    then
        curl wttr.in
    else
        #echo "wttr.in/$1"
        curl "wttr.in/$1"
    fi
}
