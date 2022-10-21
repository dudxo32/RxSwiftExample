# Type a script or drag a script file from your workspace to insert its path.

touch tempUIColorEx.swift
echo 'Make UIColorEx'

echo 'import UIKit' >> tempUIColorEx.swift
echo '' >> tempUIColorEx.swift
echo 'extension UIColor {' >> tempUIColorEx.swift
remove="${SRCROOT}/ClouDoc_iOS/Assets.xcassets/Color/"
for l in `ls -d ${SRCROOT}/ClouDoc_iOS/Assets.xcassets/Color/*`; do
	removeFront=${l/$remove/''};
    if [ "$removeFront" == "Contents.json" ]; then
        continue
    fi
    colorName=${removeFront/".colorset"/""}
	echo '    class var '${colorName}':UIColor { return  UIColor(named: "'${colorName}'")! }' >> tempUIColorEx.swift
done
echo '}' >> tempUIColorEx.swift

cat tempUIColorEx.swift > ${SRCROOT}/ClouDoc_iOS/Extensions/UIColorEx.swift
rm tempUIColorEx.swift
