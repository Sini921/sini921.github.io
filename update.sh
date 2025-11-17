#!/bin/sh

rm Packages Packages.bz2 Packages.xz

dpkg-scanpackages --multiversion rootless >> Packages
dpkg-scanpackages --multiversion roothide >> Packages

sed \
  -e '/^Name: DockX$/s//Name: DockX(rootless)/' \
  -e 's|^Description: Pasteboard shortcuts on your keyboard dock!$|Description: 键盘底部增加快捷按钮|' \
  -e 's|^Section: Tweaks$|Section: 越狱插件|' \
  -e 's|^Icon: https://udevsharold.github.io/repo/depictions/com.udevs.dockx/icon/icon.png$|Icon: https://sini921.github.io/repo/sileodepiction/icon/dockx.png|' \
  -e 's|^Sileodepiction: https://lclrc.github.io/repo/depictions/native/com.udevs.dockx/depiction.json$|Sileodepiction: https://sini921.github.io/repo/sileodepiction/dockx/js.json|' \
  -e '/^Name: Misaki$/s//Name: Misaki(rootless)/' \
  -e 's|^Description: Customize your iOS 15 & 16 experience with Misaki. customization options to make your iPhone truly yours.|Description: 大杂烩|' \
  -e '/^Tag: cydia::commercial, compatible_min::ios15.0$/d' \
  -e 's|^Icon: https://img.chariz.cloud/icon/misaki/icon@3x.png$|Icon: https://sini921.github.io/repo/sileodepiction/icon/misaki.png|' \
  -e 's|^Depiction: https://chariz.com/buy/misaki$|Sileodepiction: https://sini921.github.io/repo/sileodepiction/misaki/js.json|' \
  -e '/^Name: Hammer It$/s//Name: Hammer It(rootless)/' \
  -e 's|^Icon: file:///var/jb/Library/PreferenceBundles/HammerItPrefs.bundle/HammerIt@3x.png$|Icon: https://sini921.github.io/repo/sileodepiction/icon/hammerit.png|' \
  -e '/^Icon: https:\/\/sini921.github.io\/repo\/sileodepiction\/icon\/hammerit.png$/a\
Sileodepiction: https://sini921.github.io/repo/sileodepiction/hammerit/js.json' \
  -e 's|^Description: Control your text or translate as you wish.$|Description: 分词、翻译|' \
  Packages > Packages.new && mv Packages.new Packages

cat Packages | xz > Packages.xz
cat Packages | bzip2 > Packages.bz2

git add .
git commit -m "update repo"
git push