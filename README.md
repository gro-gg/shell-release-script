# Shell release script
This is a template to create a new release of a project with a simple shell script.
It is inspired by the [maven-release-plugin](https://maven.apache.org/maven-release/maven-release-plugin/) and will execute the following steps:
- Check that there are no uncommitted changes in the sources
- Change the version in the `.version` file to a new version (you will be prompted for the versions to use)
- Commit the modified `.version` file
- Create a new annotated git tag for the new version
- Push the release commit and the tag to origin



## Integration
Copy the files `release.sh` and `.version` to the root of your project.
You can use `.version` to display the version in your application as shown in `main.sh`.

## Usage
To create a new release type:

    ./release.sh prepare
