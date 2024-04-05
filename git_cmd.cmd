:: git clone이 URL로 클론하면
:: Remote/main Repository를 Local Repository에 clone 한다.
$ git clone https://github.com/doug2026/doug-batch.git
:: git clone을 실행할 때 다음과 같은 동작이 발생합니다.
:: 1. repo라는 새 폴더가 만들어짐
:: 2. Git 리포지토리로 초기화됨
:: 3. 복제한 URL을 가리키는 원격 이름 origin이 만들어짐
:: 4. 리포지토리의 모든 파일 및 커밋이 다운로드됨
:: 5. 기본 분기가 체크 아웃됨
:: 원격 리포지토리의 모든 분기 foo에 대해 해당 원격 추적 분기 refs/remotes/origin/foo가
:: 로컬 리포지토리에 만들어집니다.
:: 일반적으로 이러한 원격 추적 분기 이름을 origin/foo로 축약할 수 있습니다.


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

:: git status
$ git status
On branch atoffice
Your branch is up to date with 'origin/atoffice'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   git_cmd.cmd

no changes added to commit (use "git add" and/or "git commit -a")

:: git diff
$ git diff

:: git add
$ git add .

:: check git log
$ git log --oneline
f058e21 (HEAD -> atoffice, origin/atoffice) [atoffice branch] Batch programming update on 4/1 6th @Office
ffd251b [atoffice branch] Batch programming update on 4/1 5th @Office
ae1a2d7 [atoffice branch] Batch programming update on 4/1 4th @Office
65604cb [atoffice branch] Batch programming update on 4/1 3rd @Office
c8b2882 (main, athome) Batch programming update on 4/1 3rd @Office
4f6ead7 doug's batch programming on 3/30th-1 @home
ac5634c doug's batch programming on 3/30th @home
9ccff41 Update on 3/25 3rd @Office
df269f0 Update on 3/25 2nd @Office
6d18555 Update on 3/25 1st @Office
fe457ae Batch programming @office_24/02/20
66302b8 1st commit for doug's batch programming

:: git commit -m "  "
$ git commit -m "[atoffice branch] Batch programming update on 4/2 1st @Office"
[atoffice 3861268] [atoffice branch] Batch programming update on 4/2 1st @Office
 1 file changed, 20 insertions(+)

:: git log --oneline
$ git log --oneline
3861268 (HEAD -> atoffice) [atoffice branch] Batch programming update on 4/2 1st @Office
f058e21 (origin/atoffice) [atoffice branch] Batch programming update on 4/1 6th @Office
ffd251b [atoffice branch] Batch programming update on 4/1 5th @Office
ae1a2d7 [atoffice branch] Batch programming update on 4/1 4th @Office
65604cb [atoffice branch] Batch programming update on 4/1 3rd @Office
c8b2882 (main, athome) Batch programming update on 4/1 3rd @Office
4f6ead7 doug's batch programming on 3/30th-1 @home
ac5634c doug's batch programming on 3/30th @home
9ccff41 Update on 3/25 3rd @Office
df269f0 Update on 3/25 2nd @Office
6d18555 Update on 3/25 1st @Office
fe457ae Batch programming @office_24/02/20
66302b8 1st commit for doug's batch programming

:: git push origin atoffice
$ git push origin atoffice
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 22 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 926 bytes | 926.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/doug2026/doug-batch.git
   f058e21..3861268  atoffice -> atoffice


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

:: branch로 이동 : 작업할 브랜치로 바꾸는 것, 체크아웃된 브랜치에만 커밋이 반영된다.
:: $ git checkout <branch_name>
$ git checkout <branch_name>


:: git pull origin <branch_name>
:: 하나의 원격 저장소에 0개 이상의 로컬 저장소가 있을 수 있습니다.
:: 따라서, 해당 원격 저장소에 변경 사항을 push하는 주체는 다른 사람일 수도 있다는 것입니다.
:: 원격 저장소에 로컬 저장소의 변경 사항을 업로드할 때 push를 썼던 것처럼,
:: 원격 저장소의 변경 사항을 로컬 저장소로 가져오려면 pull을 사용하면 됩니다.
:: 해당 명령을 사용하면 원격 저장소에서 데이터를 가져올 뿐만 아니라, 로컬 저장소의 현재 변경 사항들이 자동으로 병합됩니다.
:: git push와 동일하게 remote가 origin, 브랜치가 현재 브랜치라면 이 둘을 생략할 수 있습니다.
$ git pull

:: Pull Request
$ git push origin atoffice
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Delta compression using up to 22 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 271 bytes | 271.00 KiB/s, done.
Total 2 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/doug2026/doug-batch.git
   ffd251b..f058e21  atoffice -> atoffice


:: HEAD -> main : 이 커밋이 지역(Local) 저장소의 최종 커밋
:: origin/main  : 원격(remote) 저장소릐 최종 커밋
:: $ git log --oneline
:: This is a shorthand for "--pretty=oneline --abbrev-commit" used together.
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

:: git Merge
:: Checkout한 브랜치를 기준으로 ?merged, ?no-merged 옵션을 사용하여
:: merge가 된 브랜치인지 아닌지 필터링할 수 있다.
$ git branch --no-merged
  atoffice

$ git branch --merged
  athome
* main

:: ‘현재' 브랜치에서 [브랜치 명]의 변경사항을 병합
:: 예를 들어 main브랜치와 atoffice 브랜치가 있다고 했을 경우, 
:: **git merge atoffice**를 하게되면 
:: atoffice브랜치에만 있던 코드가 main브랜치에 병합된다. 
:: 1. main에 체크아웃 
git checkout main

:: 2. atoffice브랜치의 코드를 main에 합침
:: git merge [브랜치명]
git merge atoffice

$ git merge atoffice
Updating c8b2882..3861268
Fast-forward
 README.md    | 4063 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  git_cmd.cmd  |  161 ++++
 git_test.txt |    1 +
 my_batch.cmd |   46 +-
 4 files changed, 4255 insertions(+), 16 deletions(-)
 create mode 100644 git_cmd.cmd
 create mode 100644 git_test.txt

:: main branch 기준으로 merge 안된 branch가 없다.
$ git branch --no-merged

:: main branch
$ git branch --merged
  athome
  atoffice
* main


:: [Git, Github] HEAD, checkout, fetch, pull
:: git Head
:: 특정 브랜치의 가장 최신 커밋을 의미합니다.
:: 브랜치라는 가지의 맨 끝 부분이라고 할 수 있습니다.
:: switch로 브랜치를 이동해서 확인해 볼 수 있습니다.
:: ^ or ~만큼 이전으로 돌리기
$ git checkout HEAD^^^
$ git checkout HEAD~5
:: Commit hash를 이용해서 이전으로 되돌리기
$ git checkout "commit hash"
:: 이동을 한단계 되돌리기(앞으로 돌리기)
::  이전으로 되돌린 Commit을 다시 앞으로 되돌립니다.
$ git checkout -
:: 어떤 Branch의 최상단으로 다시 돌아가기 위해서
$ git checkout "branch_name"

:: HEAD 사용하여 reset하기
:: git reset --hard HEAD  : (원하는 단계)
:: 해시를 찾아서 reset하는 방법이 아닌, HEAD를 이용해서 이전 commit 상태를 찾고,
::  해당 상태로 reset하는 방법입니다.
$ git reset --hard HEAD


:: fetch vs pull
:: fetch - 원격 저장소의 최신 커밋을 로컬 저장소로 가져옵니다.
:: pull - 원격 저장소의 최신 커밋을 로컬 저장소로 가져와 merge 또는 rebase합니다.
::        pull은 fetch를 포함하는 명령어입니다.

:: git fetch 적용 전 살펴보기
:: 원격 저장소에 새로운 commit이 생성 되었다고 가정하겠습니다.
:: 이때, git checkout origin/main으로 적용 전 내용을 살펴봅니다.

$ git checkout origin/main
:: 다른 커밋 해시로 상태가 변화하는 것을 알 수 있습니다.
:: 하지만 fetch를 해서 최신 커밋을 로컬 저장소로 가져오지는 않았습니다.
:: 따라서 코드의 변화는 없습니다.
:: git checkout main으로 다시 main 브랜치로 돌아와 줍니다.
$ git checkout main


:: fetch vs pull
:: fetch - 원격 저장소의 최신 커밋을 로컬 저장소로 가져옵니다.
:: pull - 원격 저장소의 최신 커밋을 로컬 저장소로 가져와 merge 또는 rebase합니다.
::         pull은 fetch를 포함하는 명령어입니다.
:: git fetch 적용 전 살펴보기
:: 원격 저장소에 새로운 commit이 생성 되었다고 가정하겠습니다.
:: 이때, git checkout origin/main으로 적용 전 내용을 살펴봅니다.

:: git fetch를 통해 원격 저장소의 commit 변경사항을 로컬 저장소에 가져와줍니다.
$ git fetch
:: git checkout으로 변경사항 조회하기
$ git checkout orign/main
:: -> 최신 커밋 내용을 받아오고, 코드도 변경되었습니다.
:: -> 새로운 commit으로 변경사항을 미리 적용해보고, merge 혹은 pull을 적용할 수 있습니다.

:: main branch로 돌아오기
$ git switch main
:: -> merge또는 pull을 하기 전에 다시 main branch로 돌아가 줍니다.

:: merge or pull하기
$ git pull
:: -> git pull로 commit 변경사항을 적용시켜 줍니다.

:: athome branch 생성하여 origin/athome 업데이트
:: 원격의 새 브랜치 확인
:: 변경사항 확인하고 최신화해주기
$ git fetch
:: -> git fetch를 통해 새로운 변경사항을 로컬 저장소에 받아옵니다.

:: 새로운 branch가 있은지 확인하기
$ git branch -a
:: -> 원격 저장소에서 새로운 브랜치가 만들어 졌는지 확인합니다.

:: 코드 변경사항 확인하기
:: git checkout origin/"브랜치 이름"
:: 다음 명령어로 새로운 브랜치에서의 코드 변경사항을 확인할 수 있습니다.
$ git checkout orign/athome2

:: main 브랜치로 다시 변경해주기
$ git switch main
:: -> 메인 브랜치로 다시 변경해 주었습니다.

:: 새로운 브랜치 로컬 저장소에 추가해주기
$ git switch -t origin/"브랜치 이름"
:: -> git switch를 통해 브랜치를 변경해주고 -t명령어를 통해서 commit을 서로 주고받을 수 있게 해줍니다.


