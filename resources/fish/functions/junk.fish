function junk
    set multiline_paths """
        /tmp/*
        $HOME/.bash_history
        $HOME/.cache/
        $HOME/.dagster/
        $HOME/.dotnet/
        $HOME/.ipython
        $HOME/.lesshst
        $HOME/.psql_history
        $HOME/.sudo_as_admin_successful
        $HOME/.trash
        $HOME/.wget-hsts
    """

    for path in (echo $multiline_paths | string split "\n" | string trim)
        if test -e $path
            /usr/bin/rm --recursive --force --verbose $path
        end
    end
end
