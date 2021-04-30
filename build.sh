rm sensu-database-check -r
mkdir sensu-database-check
docker run --rm -v "${PWD}:/src" six8/pyinstaller-alpine:alpine-3.6-pyinstaller-v3.4 --noconfirm --onefile --log-level DEBUG --clean check_redis.py
docker run --rm -v "${PWD}:/src" six8/pyinstaller-alpine:alpine-3.6-pyinstaller-v3.4 --noconfirm --onefile --log-level DEBUG --clean check_mongo.py
docker run --rm -v "${PWD}:/src" six8/pyinstaller-alpine:alpine-3.6-pyinstaller-v3.4 --noconfirm --onefile --log-level DEBUG --clean check_mariadb.py
mv dist bin
mv bin sensu-database-check/
rm build -r
rm *.spec
chmod +x sensu-database-check/bin/*
tar -C sensu-database-check -cvzf sensu-database-check-0.0.10.tar.gz .
sha512sum  sensu-database-check-0.0.10.tar.gz | tee sha512-checksums.txt
