
Because your SSH keys live in /root/.ssh/ (outside of the immutable Nix store), wiping your drive will delete them. Since they are gone, your newly rebuilt backup robot won't be able to log into GitHub on its first run; it will hit an authentication error because it doesn't have the key that matches your GitHub account.

To fix it on your fresh install, you just repeat the quick 2-minute key setup we did earlier:

Run sudo ssh-keygen -t ed25519 to make a fresh key for the root user.

Copy the new public key (cat /root/.ssh/id_ed25519.pub).

Go to GitHub and swap out the old deploy key with your new one.

Once that new key is on GitHub, the daemon immediately springs back to life and resumes its daily backups without skipping a beat! It makes distro-hopping or replacing a dead hard drive incredibly stress-free.
