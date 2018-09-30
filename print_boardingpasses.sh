_formatboardingpass() {
    filename=$(basename "$1");
    extension="${filename##*.}";
    filename="${filename%.*}";
    FILE=$(basename ${1} ${extension});
    target="_${filename}.png";

    echo "$1"
    echo "---"
    echo "1. Fix height to 700px"
    convert $1 -resize x700 +profile "*" ${target};
    echo "2. Size image to 1750x700"
    convert -size 1750x700 xc:white ${target} -gravity west -composite ${target};
    echo "3. Add padding; resize image to 2400x800"
    convert -size 2400x800 xc:white ${target} -gravity north -composite ${target};
    if [ ${target} = "_a.png" ]; then
        echo "4. Add padding-top to first image";
        convert -size 2400x900 xc:white ${target} -gravity south -composite ${target};
    fi
    echo
}

for f in a.jpg b.jpg c.jpg d.jpg
do
    _formatboardingpass $f;
done

convert -append _a.png _b.png _c.png _d.png abcd.png

rm -v _a.png _b.png _c.png _d.png

if [[ $OSTYPE == darwin* ]]; then
  open abcd.png
fi
