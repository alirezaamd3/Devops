# Vote
**This application is written in Python3.**

### Install reqirements
```sh
pip install -r reqirements.txt
```
### Run application
```sh
gunicorn app:app -b 0.0.0.0:8080 --log-file - --access-logfile - --workers 4 --keep-alive 0
```