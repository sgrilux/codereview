# codereview

**This is an ongoing project and I will be update and improving it as I learn more.**

I always struggle reviewing code of my fellows team members, and not because I can't or I don't want to, it's just that I always focused on my work and I can't keep track of all changes made and I hate context switching, once I'n in the zone I just ignore everything else.

So I want to make this better and easier, for me and for people I work with.

> I don't want to replace tools like CodeGuru which are very complex, based on ML and expensive. I just want to find a way for me (and hopefully for someone else) to help in code reviewing. 

I am a AWS Cloud Architect so I won't be focusing mostly on IaC and just few languages I mostly use for Lambdas, Python and Golang.

So here's some tools I will be using:

- `tflint` and `terraform fmt`for terraform linting
- `cfn-lint` for Cloudformation linting
- `hadolint` for Docker linting
- `checkov` 

I use Mac so installation instruction will be based on `brew` where available.

## [TFlint](https://github.com/terraform-linters/tflint)

```shell
brew install tflint
```

## [cfn-lint](https://github.com/aws-cloudformation/cfn-lint)

```shell
brew install cfn-lint
```

## [checkov](https://www.checkov.io)

```shell
pip install checkov
```

or 

```shell
pip3 install checkov
```