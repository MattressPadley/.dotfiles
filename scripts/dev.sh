#!/bin/bash

if [ "$1" = "clean" ]; then
    # For cleaning, show git status in preview and allow multiple selections
    dirs=$(fd . ~/Dev --type d --max-depth 1 --exclude .git --exclude Z_Archive -x echo {/} | sort | \
        fzf -m --preview 'preview_dir=~/Dev/{}; \
            echo "Git Status:"; \
            if [ -d "$preview_dir/.git" ]; then \
                warnings=""; \
                # Check for uncommitted changes \
                if ! git -C "$preview_dir" diff --quiet || ! git -C "$preview_dir" diff --cached --quiet; then \
                    warnings="⚠️  Uncommitted changes"; \
                fi; \
                # Check all local branches for unpushed commits \
                unpushed_branches=$(git -C "$preview_dir" branch -v | grep -v "\[gone\]" | grep "ahead" || true); \
                if [ ! -z "$unpushed_branches" ]; then \
                    if [ ! -z "$warnings" ]; then warnings="$warnings\n"; fi; \
                    warnings="${warnings}⚠️  Unpushed commits on some branches"; \
                fi; \
                # Check for branches with remote changes \
                git -C "$preview_dir" fetch --quiet; \
                behind_branches=$(git -C "$preview_dir" branch -v | grep -v "\[gone\]" | grep "behind" || true); \
                if [ ! -z "$behind_branches" ]; then \
                    if [ ! -z "$warnings" ]; then warnings="$warnings\n"; fi; \
                    warnings="${warnings}⚠️  Some branches are behind remote"; \
                fi; \
                # Check for stashed changes \
                if [ -n "$(git -C "$preview_dir" stash list)" ]; then \
                    if [ ! -z "$warnings" ]; then warnings="$warnings\n"; fi; \
                    warnings="${warnings}⚠️  Has stashed changes"; \
                fi; \
                if [ -z "$warnings" ]; then \
                    echo "✅ Clean git state (all branches up to date)"; \
                else \
                    echo -e "$warnings"; \
                fi; \
            else \
                echo "❌ Not a git repository"; \
            fi; \
            echo "\nContents:"; \
            eza --tree --level 1 --color=always "$preview_dir" | head -200' \
            --header "Select projects to DELETE (TAB to select multiple, ENTER to confirm)" \
            --preview-window up:70%)

    if [[ -n "$dirs" ]]; then
        # Show all selected directories
        echo "You have selected the following projects for deletion:"
        echo "$dirs" | while read -r dir; do
            echo "  - ~/Dev/$dir"
        done

        # Double confirm before deletion
        echo -n "Are you sure you want to delete these projects? (y/N) "
        read REPLY
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "$dirs" | while read -r dir; do
                rm -rf ~/Dev/"$dir"
                echo "Deleted ~/Dev/$dir"
            done
            echo "All selected projects have been deleted."
        else
            echo "Deletion cancelled"
        fi
    fi
else
    # Original directory navigation functionality
    dir=$(fd . ~/Dev --type d --max-depth 1 --exclude .git --exclude Z_Archive -x echo {/} | sort | \
        fzf --preview 'eza --tree --level 1 --color=always ~/Dev/{} | head -200')

    if [[ -n "$dir" ]]; then
        cd ~/Dev/"$dir" || exit
        # Need to execute this to affect parent shell
        echo "cd ~/Dev/$dir"
    fi
fi
