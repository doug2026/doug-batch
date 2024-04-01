:: git clone이 URL로 클론하면
:: Remote/main Repository를 Local Repository에 clone 한다.
$ git clone https://github.com/doug2026/doug-batch.git

:: git branch -r   # remote -v를 통해, 어디에 연결 되어있는지 볼 수 있고,
$ git remote -v
origin  https://github.com/doug2026/doug-batch.git (fetch)
origin  https://github.com/doug2026/doug-batch.git (push)

:: Remotes branch를 보여준다.
:: $ git branch --remotes
$ git branch -r
  origin/HEAD -> origin/main
  origin/main

:: $ git branch --all, Local/Remote Branch를 모두 보여준다.
$ git branch -a
  athome
* atoffice
  main
  remotes/origin/HEAD -> origin/main
  remotes/origin/atoffice
  remotes/origin/main


:: …or create a new repository on the command line
echo "# dh2110-lg" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/doug2026/dh2110-lg.git
git push -u origin main
:: …or push an existing repository from the command line
git remote add origin https://github.com/doug2026/dh2110-lg.git
git branch -M main
git push -u origin main


:: 체크아웃할 때 -b 옵션을 같이 사용하면 브랜치 생성과 이동을 한 번에 할 수 있습니다.
$ git checkout -b 브랜치이름

:: HEAD로 checkout 하기 - 바로 이전 commit으로 checkout
:: HEAD~1, 2, 3, 4, 5, 6, ...
$ git checkout HEAD~1
:: 현재 시점으로 돌아 올때
$ git checkout -

:: 커밋해시키로 checkout 하기
$ git checkout 커밋해시키

:: 아무런 옵션 없이 실행하면 브랜치의 목록을 보여준다.
$ git branch
  athome
* atoffice
  main
:: * 기호가 붙어 있는 master 브랜치는 현재 Checkout 해서 작업하는 브랜치를 나타낸다.
:: 즉, 지금 수정한 내용을 커밋하면 main 브랜치에 커밋되고 포인터가 앞으로 한 단계 나아간다.
:: 브랜치마다 마지막 커밋 메시지도 함께 보여준다.
:: git remote -v   # git branch -r을 통해서, origin/main이 Remote Tracking Branch인 것을 볼 수 있다.
:: 등록된 branch의 상세한 정보 확인
$ git branch -v
  athome   c8b2882 Batch programming update on 4/1 3rd @Office
* atoffice 65604cb [atoffice branch] Batch programming update on 4/1 3rd @Office
  main     c8b2882 Batch programming update on 4/1 3rd @Office

$ git branch -vv
  athome   c8b2882 Batch programming update on 4/1 3rd @Office
* atoffice ae1a2d7 [origin/atoffice] [atoffice branch] Batch programming update on 4/1 4th @Office
  main     c8b2882 [origin/main] Batch programming update on 4/1 3rd @Office

:: act on remote-tracking branches
$ git branch --remotes
  origin/HEAD -> origin/main
  origin/atoffice
  origin/main

$ git branch -r
  origin/HEAD -> origin/main
  origin/atoffice
  origin/main


:: git pull origin <branch_name>
:: 하나의 원격 저장소에 0개 이상의 로컬 저장소가 있을 수 있습니다.
:: 따라서, 해당 원격 저장소에 변경 사항을 push하는 주체는 다른 사람일 수도 있다는 것입니다.
:: 원격 저장소에 로컬 저장소의 변경 사항을 업로드할 때 push를 썼던 것처럼,
:: 원격 저장소의 변경 사항을 로컬 저장소로 가져오려면 pull을 사용하면 됩니다.
:: 해당 명령을 사용하면 원격 저장소에서 데이터를 가져올 뿐만 아니라, 로컬 저장소의 현재 변경 사항들이 자동으로 병합됩니다.
:: git push와 동일하게 remote가 origin, 브랜치가 현재 브랜치라면 이 둘을 생략할 수 있습니다.
$ git pull

:: Pull Request


:: HEAD -> main : 이 커밋이 지역(Local) 저장소의 최종 커밋
:: origin/main  : 원격(remote) 저장소릐 최종 커밋
$ git log --oneline
65604cb (HEAD -> atoffice, origin/atoffice) [atoffice branch] Batch programming update on 4/1 3rd @Office
c8b2882 (origin/main, origin/HEAD, main, athome) Batch programming update on 4/1 3rd @Office
4f6ead7 doug's batch programming on 3/30th-1 @home
ac5634c doug's batch programming on 3/30th @home
9ccff41 Update on 3/25 3rd @Office
df269f0 Update on 3/25 2nd @Office
6d18555 Update on 3/25 1st @Office
fe457ae Batch programming @office_24/02/20
66302b8 1st commit for doug's batch programming

:: ae1a2d7 commit만 하고 push 하기 전 상태
:: HEAD -> atoffice : Local Repository의 HEAD
:: origin/atoffice  : Remote/atoffice Repository의 HEAD
:: origin/main, origin/HEAD, main, athome : Remote/main & Remote/athome Repository의 HEAD
$ git log --oneline
ae1a2d7 (HEAD -> atoffice) [atoffice branch] Batch programming update on 4/1 4th @Office
65604cb (origin/atoffice) [atoffice branch] Batch programming update on 4/1 3rd @Office
c8b2882 (origin/main, origin/HEAD, main, athome) Batch programming update on 4/1 3rd @Office
4f6ead7 doug's batch programming on 3/30th-1 @home
ac5634c doug's batch programming on 3/30th @home
9ccff41 Update on 3/25 3rd @Office
df269f0 Update on 3/25 2nd @Office
6d18555 Update on 3/25 1st @Office
fe457ae Batch programming @office_24/02/20
66302b8 1st commit for doug's batch programming

:: ae1a2d7 push 후의 git 상태
:: Local Repository HEAD -> atoffice, origin/atoffice과 동일
$ git log --oneline
ae1a2d7 (HEAD -> atoffice, origin/atoffice) [atoffice branch] Batch programming update on 4/1 4th @Office
65604cb [atoffice branch] Batch programming update on 4/1 3rd @Office
c8b2882 (origin/main, origin/HEAD, main, athome) Batch programming update on 4/1 3rd @Office
4f6ead7 doug's batch programming on 3/30th-1 @home
ac5634c doug's batch programming on 3/30th @home
9ccff41 Update on 3/25 3rd @Office
df269f0 Update on 3/25 2nd @Office
6d18555 Update on 3/25 1st @Office
fe457ae Batch programming @office_24/02/20
66302b8 1st commit for doug's batch programming




