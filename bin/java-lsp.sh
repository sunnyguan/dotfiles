#!/bin/bash

JAR="/Users/test/.local/share/vim-lsp-settings/servers/eclipse-jdt-ls/plugins/org.eclipse.equinox.launcher_1.6.0.v20200915-1508.jar"

GRADLE_HOME=$HOME/gradle /usr/local/opt/openjdk/bin/java \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  -jar $(echo "$JAR") \
  -configuration "/Users/test/.local/share/vim-lsp-settings/servers/eclipse-jdt-ls/config_mac" \
  -data "${1:-$HOME/workspace}" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED

