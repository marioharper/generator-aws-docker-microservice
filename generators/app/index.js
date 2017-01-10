var Generator = require('yeoman-generator');

class MyBase extends Generator {
  // private methods here
  helper() {
    this.log('this is not called')
  }
}

module.exports = class extends MyBase {
  constructor(args, opts) {
    super(args, opts);

    this.argument('appname', { type: String, required: false, default: this.appname });
  }

  prompting() {
    this.log('Welcome to the aws-docker-microservice generator. It\'s dope!');
  }

  writing() {
    this.fs.copyTpl(
      this.templatePath() + '/**',
      this.destinationPath(),
      { 
        title: this.options.appname,
        dockerImage: this.options.dockerImage
      }
    );

    const mv = (from, to) => {
			this.fs.move(this.destinationPath(from), this.destinationPath(to));
		};

    mv('gitignore', '.gitignore');
  }

  install() {
		this.installDependencies({bower: false});
	}
};