# Maven

This repo packages [Maven](https://maven.apache.org/index.html) for use in
[rkt](https://coreos.com/rkt).

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [Maven](#maven)
    - [Use](#use)
    - [Hacking](#hacking)
    - [License](#license)

<!-- markdown-toc end -->

## Use

This image is best used as a dependency. You can specify it as
`pkg.aster.is/aci/maven:3.3.9` (or any other released version at that URL.)

## Hacking

With [`acbuild`](https://github.com/appc/acbuild) installed, run `make
dnsmasq-3.3.9-linux-amd64.aci` or `make all DNSMASQ_VERSION=3.3.9` to create and
sign.

## License

See [LICENSE](LICENSE).
