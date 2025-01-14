This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 or systemd-boot on Linux, so
asking us to endorse anything else for signing is going to require some convincing on
your part.

Check the docs directory in this repo for guidance on submission and
getting your shim signed.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************
Egor Ignatov for
ALT Linux

*******************************************************************************
### What product or service is this for?
*******************************************************************************
ALT Linux \
https://en.altlinux.org/

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************
ALT Linux is a GNU/Linux distribution that supports Secure Boot

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************
We are an independent GNU/Linux distribution and ship our own signed builds of
grub and linux kernel, so shim from another distro won't load our system

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
*******************************************************************************
- Name: Egor Ignatov
- Position: Software Engineer
- Email address: egori@altlinux.org
- PGP key fingerprint: E2FB 9E0D 4AEB 306D 2878 D8D3 DB21 C97B 6BDF 202A
- See the file keys/egori.pub in this git repo

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: Gleb Fotengauer-Malinovskiy
- Position: Lead Software Engineer
- Email address: glebfm@altlinux.org
- PGP key fingerprint: 3F07 F25C 98B6 714D 8809 C8DF DE50 4C15 D098 D624
- See the file keys/glebfm.pub in this git repo

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Were these binaries created from the 15.8 shim release tar?
Please create your shim binaries starting with the 15.8 shim release tar file: https://github.com/rhboot/shim/releases/download/15.8/shim-15.8.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.8 and contains the appropriate gnu-efi source.

*******************************************************************************
Yes

*******************************************************************************
### URL for a repo that contains the exact code which was built to get this binary:
*******************************************************************************
https://git.altlinux.org/gears/s/shim.git for Sisyphus repository RPM-package build

*******************************************************************************
### What patches are being applied and why:
*******************************************************************************
- shim-15.8-alt-Bump-grub-SBAT-revocation-to-4.patch - patch to revoke grub with SBAT less than 4

*******************************************************************************
### Do you have the NX bit set in your shim? If so, is your entire boot stack NX-compatible and what testing have you done to ensure such compatibility?

See https://techcommunity.microsoft.com/t5/hardware-dev-center/nx-exception-for-shim-community/ba-p/3976522 for more details on the signing of shim without NX bit.
*******************************************************************************
No, it's not set

*******************************************************************************
### If shim is loading GRUB2 bootloader what exact implementation of Secureboot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
*******************************************************************************
Upstream GRUB2 shim_lock verifier

*******************************************************************************
### If shim is loading GRUB2 bootloader and your previously released shim booted a version of GRUB2 affected by any of the CVEs in the July 2020, the March 2021, the June 7th 2022, the November 15th 2022, or 3rd of October 2023 GRUB2 CVE list, have fixes for all these CVEs been applied?

* 2020 July - BootHole
  * Details: https://lists.gnu.org/archive/html/grub-devel/2020-07/msg00034.html
  * CVE-2020-10713
  * CVE-2020-14308
  * CVE-2020-14309
  * CVE-2020-14310
  * CVE-2020-14311
  * CVE-2020-15705
  * CVE-2020-15706
  * CVE-2020-15707
* March 2021
  * Details: https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html
  * CVE-2020-14372
  * CVE-2020-25632
  * CVE-2020-25647
  * CVE-2020-27749
  * CVE-2020-27779
  * CVE-2021-3418 (if you are shipping the shim_lock module)
  * CVE-2021-20225
  * CVE-2021-20233
* June 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-06/msg00035.html, SBAT increase to 2
  * CVE-2021-3695
  * CVE-2021-3696
  * CVE-2021-3697
  * CVE-2022-28733
  * CVE-2022-28734
  * CVE-2022-28735
  * CVE-2022-28736
  * CVE-2022-28737
* November 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-11/msg00059.html, SBAT increase to 3
  * CVE-2022-2601
  * CVE-2022-3775
* October 2023 - NTFS vulnerabilities
  * Details: https://lists.gnu.org/archive/html/grub-devel/2023-10/msg00028.html, SBAT increase to 4
  * CVE-2023-4693
  * CVE-2023-4692
*******************************************************************************
Yes

*******************************************************************************
### If shim is loading GRUB2 bootloader, and if these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 4?
The entry should look similar to: `grub,4,Free Software Foundation,grub,GRUB_UPSTREAM_VERSION,https://www.gnu.org/software/grub/`
*******************************************************************************
Yes, we have
`grub,4,Free Software Foundation,grub,2.06,https://www.gnu.org/software/grub/`


*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
*******************************************************************************
This is the fisrt submission.
The new chain of trust disallows booting old GRUB2 builds using SBAT.

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
*******************************************************************************
Yes, all three patches are applied to our signed kernel builds

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************
We have applied lockdown patches, nothing else that might be security relevant here

*******************************************************************************
### Do you use an ephemeral key for signing kernel modules?
### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.
*******************************************************************************
Yes

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************
Only one built-in certificate is used.

No allow-listed hashes

*******************************************************************************
### If you are re-using a previously used (CA) certificate, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs to vendor_dbx in shim in order to prevent GRUB2 from being able to chainload those older GRUB2 binaries. If you are changing to a new (CA) certificate, this does not apply.
### Please describe your strategy.
*******************************************************************************
N/A

*******************************************************************************
### What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as closely as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
### If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
*******************************************************************************
Dockerfile to reproduce this build is included.

Тhe resulting image contains the following artifacts:
1. /home/builder/build-{ia32,x64}.log - shim binaries rebuild logs
2. /home/builder/shim-15.8/build-ia32/shimia32.efi - rebuilt ia32 binary
3. /home/builder/shim-15.8/build-x64/shimx64.efi - rebuilt x64 binary
4. /home/builder/shim-review/shimia32.efi - submitted ia32 binary
5. /home/builder/shim-review/shimx64.efi - submitted x64 binary

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************
`build-ia32.log` for ia32 build and `build-x64.log` for x86_64 build

*******************************************************************************
### What changes were made in the distor's secure boot chain since your SHIM was last signed?
For example, signing new kernel's variants, UKI, systemd-boot, new certs, new CA, etc..
*******************************************************************************
N/A

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
`dc20046109d30c8353a6cf37e6666901d9bdfe38b9ac7166652ca9c3a064e742  shimia32.efi`
`7b698a7100eabf0e75f5896e898156e4d122b06f04467365ca79c3295d48b8b3  shimx64.efi`

*******************************************************************************
### How do you manage and protect the keys used in your SHIM?
*******************************************************************************
The keys are stored on HSM with restricted access.
Only few trusted persons have sign authority.

*******************************************************************************
### Do you use EV certificates as embedded certificates in the SHIM?
*******************************************************************************
No

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, systemd-boot, systemd-stub, shim + all child shim binaries )?
### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim.
### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation.
If you are using a downstream implementation of GRUB2 or systemd-boot (e.g.
from Fedora or Debian), please preserve the SBAT entry from those distributions
and only append your own. More information on how SBAT works can be found
[here](https://github.com/rhboot/shim/blob/main/SBAT.md).
*******************************************************************************

shim (and all child shim binaries)
```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,4,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.altlinux,1,ALT Linux,shim,15.8-alt1,http://git.altlinux.org/gears/s/shim.git
```

grub
```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,4,Free Software Foundation,grub,2.06,https://www.gnu.org/software/grub/
grub.altlinux,1,ALT Linux,grub,2.06-alt18,http://git.altlinux.org/gears/g/grub.git
```

fwupd
```
sbat,1,UEFI shim,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
fwupd-efi,1,Firmware update daemon,fwupd-efi,1.4,https://github.com/fwupd/fwupd-efi
fwupd-efi.altlinux,1,ALT Linux,fwupd-efi,1.4-alt2,http://git.altlinux.org/gears/f/fwupd-efi.git
```

*******************************************************************************
### If shim is loading GRUB2 bootloader, which modules are built into your signed GRUB2 image?
*******************************************************************************
```
part_gpt part_apple part_msdos hfsplus fat ext2 btrfs xfs
squash4 normal chain boot configfile diskfilter
minicmd reboot halt search search_fs_uuid search_fs_file
search_label sleep test syslinuxcfg all_video video font
gfxmenu gfxterm gfxterm_background lvm lsefi efifwsetup cat
gzio iso9660 loadenv loopback mdraid09 mdraid1x png jpeg
extcmd keystatus procfs cryptodisk gcry_rijndael gcry_sha1
gcry_sha256 luks gcry_sha512 gcry_serpent gcry_twofish
crypto pbkdf2 password_pbkdf2 echo regexp tftp
f2fs exfat ntfs ntfscomp
```

*******************************************************************************
### If you are using systemd-boot on arm64 or riscv, is the fix for [unverified Devicetree Blob loading](https://github.com/systemd/systemd/security/advisories/GHSA-6m6p-rjcq-334c) included?
*******************************************************************************
N/A

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB2 or systemd-boot or other)?
*******************************************************************************
upstream grub-2.06 including patches for all currently discussed security issues

*******************************************************************************
### If your SHIM launches any other components, please provide further details on what is launched.
*******************************************************************************
It will load fwupd as already mentioned above.

*******************************************************************************
### If your GRUB2 or systemd-boot launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
*******************************************************************************
N/A

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
*******************************************************************************
GRUB and kernel are patched to enforce Secure Boot.
Fwupd is authenticated and does not execute other binaries.

*******************************************************************************
### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB2)?
*******************************************************************************
No

*******************************************************************************
### What kernel are you using? Which patches does it includes to enforce Secure Boot?
*******************************************************************************
All our signed kernels include lockdown patches

In stable branch:  
[5.10 std-def](https://git.altlinux.org/gears/k/kernel-image-std-def.git?p=kernel-image-std-def.git;a=shortlog;h=refs/heads/p10): standard longterm kernel  
[6.1 un-def](https://git.altlinux.org/gears/k/kernel-image-un-def.git?p=kernel-image-un-def.git;a=shortlog;h=refs/heads/p10): more modern than std-def and with forced preemption enabled   

In unstable branch:  
[6.1 std-def](https://git.altlinux.org/gears/k/kernel-image-std-def.git) standard longterm kernel  
[6.6 un-def](https://git.altlinux.org/gears/k/kernel-image-un-def.git) more modern than std-def and with forced preemption enabled

*******************************************************************************
### Add any additional information you think we may need to validate this shim.
*******************************************************************************
No
