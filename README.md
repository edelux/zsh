# Project under construction

## zsh, tmux and vim Environment for DevOps

Welcome to our GitHub repository! This project is aimed at containerizing my working environment, integrating a collection of commonly used DevOps tools along with minimalist configurations for vim, zsh, and tmux. Our goal is to create a seamless and efficient workflow for developers who value a clean and effective setup.

## Features

- **Containerized Environment**: Utilize containers to encapsulate the development environment, ensuring compatibility and reproducibility across different systems.
- **DevOps Tools Integration**: Access a curated set of tools for continuous integration/continuous deployment (CI/CD), monitoring, and automation.
- **Minimalist Configurations**:
  - **vim**: Streamlined vi setup for those who appreciate the power and simplicity of this text editor.
  - **zsh**: Customized zsh configuration for an enhanced command-line experience.
  - **tmux**: Setup tmux to allow for multitasking in a single terminal window with minimal overhead.
- **Security Layer**:
  - **encfs**: Implement a lightweight encryption filesystem to secure sensitive data.
  - **keychain**: Manage SSH and GPG keys with ease, ensuring secure access to repositories and services.
  - **pass**: A minimalist password manager that keeps your credentials safe and accessible.
  - **cloudflared**: Utilize Cloudflare's DNS over SSL proxy to protect your DNS queries and enhance privacy.

## Getting Started

To get started with this project, you'll need to have Docker installed on your system. Clone this repository and follow the setup instructions to build your containerized environment.

```sh
docker pull edelux/zsh
```

## Usage

Once the environment is set up, you can start using the integrated tools for your development tasks, along with managing your sensitive data securely using the persistent volume.

Here's how to use the persistent volume with your container:

```sh
docker volume create zsh
docker run --rm --privileged --name zsh -v ${PWD}:/shared -v zsh:/data -v /var/run/docker.sock:/var/run/docker.sock -e DOCKERGID=124 -it edelux/zsh
```

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement". Don't forget to give the project a star! Thanks again!

## License

Distributed under the MIT License. See [LICENSE](https://www.mit.edu/~amini/LICENSE.md) for more information.
