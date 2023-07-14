# Snap Node Cert Exporter

The snap-node-cert-exporter is a snap for the [node-cert-exporter](https://github.com/amimof/node-cert-exporter.git).

## Getting Started

Install the snap from snap store and start the exporter:

```bash
$ snap install node-cert-exporter
```

By default, the exporter listening on port `9117`. You can check the metric by
running:

```bash
$ curl localhost:9117/metrics
```

**(Optional)** If the `system-files` interface is not connected automatically,
you can connect the `system-files` interface manually, this will allow the snap
to have read access to some directories in your host's `/etc` (`/etc/ovn` and
`/etc/neutron` in particular), which is needed for the exporter to read your
certificates:

```bash
$ snap connect node-cert-exporter:etc-ovn
$ snap connect node-cert-exporter:etc-neutron
```

## Snap Configuration

By default, the snap will read and expose the expiration information of the
certificates reside in `/etc/ovn` and `/etc/neutron` with the extension of
[".pem", ".crt", ".cert", ".cer", ".pfx"] to Prometheus as metrics. However, you
can still fine-tune what certificates (within `/etc/ovn` and `/etc/neutron`) to
be included of the exporter via the snap configuration.

You can get a list of supported snap configuration via

```bash
$ snap get node-cert-exporter
```

You can change the default configuration by running `snap set node-cert-exporter
<key>=<value>`. For example, you can include the certificates without the
appropriate extensions:

```bash
$ snap set node-cert-exporter include-glob="/etc/ovn/cert_host"
```

You can also revert to the default vaule by running `snap unset
node-cert-exporter <key>`. For example, you can revert the `include-glob`
option.

```bash
$ snap unset node-cert-exporter include-glob
```

## Local Build and Testing

You need `snapcraft` to build the snap:

```bash
$ sudo snap install snapcraft --classic
```

Snapcraft also requires backend to create isolated build environment, you can
choose the following two backends:

- [LXD](https://linuxcontainers.org/lxd/introduction/), which creates container
  image build instances. It can be used inside virtual machines.
- [Multipass](https://multipass.run/), which creates virtual machine build
  instances. It cannot be reliably used on platforms that do not support nested
  virtualization. For instance, Multipass will most likely not run inside a
  virtual machine itself.

To build the snap:

```bash
$ make build
```

To try the snap that was built, you can install it locally:

```bash
$ make install
```

To clean up, you can run:

```bash
$ make uninstall
$ make clean
```
