## How this is setup
Just a few notes to my future self.

This site is using a Rakefile to generate and publish.

The commands are simple.

### Build/Generate site
    rake generate

### Publish to GitHub
    rake publish

### Push images etc
You will also need to push images etc to Github so to do that, add and commit as usual and then run the following push command:

    git push --all origin
