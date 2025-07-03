nix-collect-garbage --delete-old
paths=$(ls /nix/var/nix/profiles/)
pathsarr=($paths)
for i in "${pathsarr[@]}"; do
	:
	if [ "$i" != "${pathsarr[-1]}" ] && [ "$i" != "per-user" ] && [ "$i" != "system" ]; then
		sudo rm "/nix/var/nix/profiles/$i"
	fi
done
nix-store --gc
