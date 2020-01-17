#!/bin/sh

# Test that the session is restored when the BSSID is passed on the command line

set -ef

echo "asciipsk" > ${abs_builddir}/1word

cat > ${abs_builddir}/session << EOF
${abs_builddir}
00:0D:93:EB:B0:8C
0 16138 0
6
${top_builddir}/src/aircrack-ng${EXEEXT}
${abs_srcdir}/wpa.cap
-w
${abs_srcdir}/password.lst,${abs_builddir}/1word
-b
00:0D:93:EB:B0:8C
EOF

"${abs_builddir}/../aircrack-ng${EXEEXT}" \
    -R ${abs_builddir}/session | \
        ${GREP} 'KEY NOT FOUND'

rm -f ${abs_builddir}/1word

if [ -f ${abs_builddir}/session ]; then
	rm ${abs_builddir}/session
fi

exit 0

