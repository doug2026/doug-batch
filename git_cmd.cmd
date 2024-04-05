:: git clone�� URL�� Ŭ���ϸ�
:: Remote/main Repository�� Local Repository�� clone �Ѵ�.
$ git clone https://github.com/doug2026/doug-batch.git
:: git clone�� ������ �� ������ ���� ������ �߻��մϴ�.
:: 1. repo��� �� ������ �������
:: 2. Git �������丮�� �ʱ�ȭ��
:: 3. ������ URL�� ����Ű�� ���� �̸� origin�� �������
:: 4. �������丮�� ��� ���� �� Ŀ���� �ٿ�ε��
:: 5. �⺻ �бⰡ üũ �ƿ���
:: ���� �������丮�� ��� �б� foo�� ���� �ش� ���� ���� �б� refs/remotes/origin/foo��
:: ���� �������丮�� ��������ϴ�.
:: �Ϲ������� �̷��� ���� ���� �б� �̸��� origin/foo�� ����� �� �ֽ��ϴ�.


:: git branch -r   # remote -v�� ����, ��� ���� �Ǿ��ִ��� �� �� �ְ�,
$ git remote -v
origin  https://github.com/doug2026/doug-batch.git (fetch)
origin  https://github.com/doug2026/doug-batch.git (push)

:: Remotes branch�� �����ش�.
:: $ git branch --remotes
$ git branch -r
  origin/HEAD -> origin/main
  origin/main

:: $ git branch --all, Local/Remote Branch�� ��� �����ش�.
$ git branch -a
  athome
* atoffice
  main
  remotes/origin/HEAD -> origin/main
  remotes/origin/atoffice
  remotes/origin/main


:: ��or create a new repository on the command line
echo "# dh2110-lg" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/doug2026/dh2110-lg.git
git push -u origin main
:: ��or push an existing repository from the command line
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


:: üũ�ƿ��� �� -b �ɼ��� ���� ����ϸ� �귣ġ ������ �̵��� �� ���� �� �� �ֽ��ϴ�.
$ git checkout -b �귣ġ�̸�

:: HEAD�� checkout �ϱ� - �ٷ� ���� commit���� checkout
:: HEAD~1, 2, 3, 4, 5, 6, ...
$ git checkout HEAD~1
:: ���� �������� ���� �ö�
$ git checkout -

:: Ŀ���ؽ�Ű�� checkout �ϱ�
$ git checkout Ŀ���ؽ�Ű

:: �ƹ��� �ɼ� ���� �����ϸ� �귣ġ�� ����� �����ش�.
$ git branch
  athome
* atoffice
  main
:: * ��ȣ�� �پ� �ִ� master �귣ġ�� ���� Checkout �ؼ� �۾��ϴ� �귣ġ�� ��Ÿ����.
:: ��, ���� ������ ������ Ŀ���ϸ� main �귣ġ�� Ŀ�Եǰ� �����Ͱ� ������ �� �ܰ� ���ư���.
:: �귣ġ���� ������ Ŀ�� �޽����� �Բ� �����ش�.
:: git remote -v   # git branch -r�� ���ؼ�, origin/main�� Remote Tracking Branch�� ���� �� �� �ִ�.
:: ��ϵ� branch�� ���� ���� Ȯ��
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

:: branch�� �̵� : �۾��� �귣ġ�� �ٲٴ� ��, üũ�ƿ��� �귣ġ���� Ŀ���� �ݿ��ȴ�.
:: $ git checkout <branch_name>
$ git checkout <branch_name>


:: git pull origin <branch_name>
:: �ϳ��� ���� ����ҿ� 0�� �̻��� ���� ����Ұ� ���� �� �ֽ��ϴ�.
:: ����, �ش� ���� ����ҿ� ���� ������ push�ϴ� ��ü�� �ٸ� ����� ���� �ִٴ� ���Դϴ�.
:: ���� ����ҿ� ���� ������� ���� ������ ���ε��� �� push�� ��� ��ó��,
:: ���� ������� ���� ������ ���� ����ҷ� ���������� pull�� ����ϸ� �˴ϴ�.
:: �ش� ����� ����ϸ� ���� ����ҿ��� �����͸� ������ �Ӹ� �ƴ϶�, ���� ������� ���� ���� ���׵��� �ڵ����� ���յ˴ϴ�.
:: git push�� �����ϰ� remote�� origin, �귣ġ�� ���� �귣ġ��� �� ���� ������ �� �ֽ��ϴ�.
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


:: HEAD -> main : �� Ŀ���� ����(Local) ������� ���� Ŀ��
:: origin/main  : ����(remote) ����Ґl ���� Ŀ��
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

:: ae1a2d7 commit�� �ϰ� push �ϱ� �� ����
:: HEAD -> atoffice : Local Repository�� HEAD
:: origin/atoffice  : Remote/atoffice Repository�� HEAD
:: origin/main, origin/HEAD, main, athome : Remote/main & Remote/athome Repository�� HEAD
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

:: ae1a2d7 push ���� git ����
:: Local Repository HEAD -> atoffice, origin/atoffice�� ����
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
:: Checkout�� �귣ġ�� �������� ?merged, ?no-merged �ɼ��� ����Ͽ�
:: merge�� �� �귣ġ���� �ƴ��� ���͸��� �� �ִ�.
$ git branch --no-merged
  atoffice

$ git branch --merged
  athome
* main

:: ������' �귣ġ���� [�귣ġ ��]�� ��������� ����
:: ���� ��� main�귣ġ�� atoffice �귣ġ�� �ִٰ� ���� ���, 
:: **git merge atoffice**�� �ϰԵǸ� 
:: atoffice�귣ġ���� �ִ� �ڵ尡 main�귣ġ�� ���յȴ�. 
:: 1. main�� üũ�ƿ� 
git checkout main

:: 2. atoffice�귣ġ�� �ڵ带 main�� ��ħ
:: git merge [�귣ġ��]
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

:: main branch �������� merge �ȵ� branch�� ����.
$ git branch --no-merged

:: main branch
$ git branch --merged
  athome
  atoffice
* main


:: [Git, Github] HEAD, checkout, fetch, pull
:: git Head
:: Ư�� �귣ġ�� ���� �ֽ� Ŀ���� �ǹ��մϴ�.
:: �귣ġ��� ������ �� �� �κ��̶�� �� �� �ֽ��ϴ�.
:: switch�� �귣ġ�� �̵��ؼ� Ȯ���� �� �� �ֽ��ϴ�.
:: ^ or ~��ŭ �������� ������
$ git checkout HEAD^^^
$ git checkout HEAD~5
:: Commit hash�� �̿��ؼ� �������� �ǵ�����
$ git checkout "commit hash"
:: �̵��� �Ѵܰ� �ǵ�����(������ ������)
::  �������� �ǵ��� Commit�� �ٽ� ������ �ǵ����ϴ�.
$ git checkout -
:: � Branch�� �ֻ������ �ٽ� ���ư��� ���ؼ�
$ git checkout "branch_name"

:: HEAD ����Ͽ� reset�ϱ�
:: git reset --hard HEAD  : (���ϴ� �ܰ�)
:: �ؽø� ã�Ƽ� reset�ϴ� ����� �ƴ�, HEAD�� �̿��ؼ� ���� commit ���¸� ã��,
::  �ش� ���·� reset�ϴ� ����Դϴ�.
$ git reset --hard HEAD


:: fetch vs pull
:: fetch - ���� ������� �ֽ� Ŀ���� ���� ����ҷ� �����ɴϴ�.
:: pull - ���� ������� �ֽ� Ŀ���� ���� ����ҷ� ������ merge �Ǵ� rebase�մϴ�.
::        pull�� fetch�� �����ϴ� ��ɾ��Դϴ�.

:: git fetch ���� �� ���캸��
:: ���� ����ҿ� ���ο� commit�� ���� �Ǿ��ٰ� �����ϰڽ��ϴ�.
:: �̶�, git checkout origin/main���� ���� �� ������ ���캾�ϴ�.

$ git checkout origin/main
:: �ٸ� Ŀ�� �ؽ÷� ���°� ��ȭ�ϴ� ���� �� �� �ֽ��ϴ�.
:: ������ fetch�� �ؼ� �ֽ� Ŀ���� ���� ����ҷ� ���������� �ʾҽ��ϴ�.
:: ���� �ڵ��� ��ȭ�� �����ϴ�.
:: git checkout main���� �ٽ� main �귣ġ�� ���ƿ� �ݴϴ�.
$ git checkout main


:: fetch vs pull
:: fetch - ���� ������� �ֽ� Ŀ���� ���� ����ҷ� �����ɴϴ�.
:: pull - ���� ������� �ֽ� Ŀ���� ���� ����ҷ� ������ merge �Ǵ� rebase�մϴ�.
::         pull�� fetch�� �����ϴ� ��ɾ��Դϴ�.
:: git fetch ���� �� ���캸��
:: ���� ����ҿ� ���ο� commit�� ���� �Ǿ��ٰ� �����ϰڽ��ϴ�.
:: �̶�, git checkout origin/main���� ���� �� ������ ���캾�ϴ�.

:: git fetch�� ���� ���� ������� commit ��������� ���� ����ҿ� �������ݴϴ�.
$ git fetch
:: git checkout���� ������� ��ȸ�ϱ�
$ git checkout orign/main
:: -> �ֽ� Ŀ�� ������ �޾ƿ���, �ڵ嵵 ����Ǿ����ϴ�.
:: -> ���ο� commit���� ��������� �̸� �����غ���, merge Ȥ�� pull�� ������ �� �ֽ��ϴ�.

:: main branch�� ���ƿ���
$ git switch main
:: -> merge�Ǵ� pull�� �ϱ� ���� �ٽ� main branch�� ���ư� �ݴϴ�.

:: merge or pull�ϱ�
$ git pull
:: -> git pull�� commit ��������� ������� �ݴϴ�.

:: athome branch �����Ͽ� origin/athome ������Ʈ
:: ������ �� �귣ġ Ȯ��
:: ������� Ȯ���ϰ� �ֽ�ȭ���ֱ�
$ git fetch
:: -> git fetch�� ���� ���ο� ��������� ���� ����ҿ� �޾ƿɴϴ�.

:: ���ο� branch�� ������ Ȯ���ϱ�
$ git branch -a
:: -> ���� ����ҿ��� ���ο� �귣ġ�� ����� ������ Ȯ���մϴ�.

:: �ڵ� ������� Ȯ���ϱ�
:: git checkout origin/"�귣ġ �̸�"
:: ���� ��ɾ�� ���ο� �귣ġ������ �ڵ� ��������� Ȯ���� �� �ֽ��ϴ�.
$ git checkout orign/athome2

:: main �귣ġ�� �ٽ� �������ֱ�
$ git switch main
:: -> ���� �귣ġ�� �ٽ� ������ �־����ϴ�.

:: ���ο� �귣ġ ���� ����ҿ� �߰����ֱ�
$ git switch -t origin/"�귣ġ �̸�"
:: -> git switch�� ���� �귣ġ�� �������ְ� -t��ɾ ���ؼ� commit�� ���� �ְ���� �� �ְ� ���ݴϴ�.


