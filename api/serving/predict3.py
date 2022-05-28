from google.cloud import automl
import os
import re
import tempfile
from flask import Flask, request, Response, render_template, jsonify
import json

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "../custom-qwiklabs-jerry-4596e2ad8f8d.json"

# TODO(developer): Uncomment and set the following variables
project_id = "custom-qwiklabs-jerry"
# model_id = "TCN4052120361796370432"       # 2021/04/23
model_id = "TCN818254354367643648"  # 2021/05/02

app = Flask(__name__)


@app.route("/")
def root():
    return render_template("ui.html")

@app.route("/api/dump", methods=['POST'])
def getDumpData():
    dump = request.json
    
    jsonData = json.loads(dump)
    
    for key in jsonData.keys():
            if key != 'created':
                thread = jsonData[key]
                stack = '\n'.join(thread['stack'])
                file_st = open('dumps/threads/{0:07d}.txt'.format(idx), 'w')
                idx = idx + 1
                file_st.write(stack)
                file_st.close()
                # thread의 이름에서 영어, 띄워쓰기만 남기고 나머지(숫자, 기호 등) 삭제 
                name = re.sub('[^ a-zA-Z]','',thread['name'])
                stack = re.sub('^\"[^\"]*\"', name, stack)
                
                #스레드의 고유번호(#1234), 포인터 저장 위치(형식 [0x000], <0x000>) 삭제
                stack = re.sub('#[0-9]+|\[[^)]*?\]|\<[^)]*?\>', '', stack)
                
                #공백, .(온점), (, ), ,(반점) 기준으로 split
                words = re.split(' |\.|\(|\)|\n|,', stack)
                
                dehydrated_words = []
                for word in words:
                    #비워있는 word 스킵
                    if word == '' : continue
                    
                    #java: 형식으로 되어있는 코드 행 삭제, prio=, os_prio, tid, nid 가 포함된 단어 삭제
                    #javax, at, java, com, org 처럼 의미없이 자주 출현하는 단어 삭제(불용어 처리)
                    if word.find('java:') == -1 and word.find('prio=') == -1 and word.find('id=') == -1 and \
                    word != 'javax' and word != 'at' and word != 'java' and word != 'com' and word != 'org':
                        dehydrated_words.append(word)

    content = ' '.join(dehydrated_words)
    print(dehydrated_words, flush=True)

    # autoML Service Client 불러오기
    prediction_client = automl.PredictionServiceClient()

    # Get the full path of the model.
    model_full_id = automl.AutoMlClient.model_path(project_id, "us-central1", model_id)

    # Supported mime_types: 'text/plain', 'text/html'
    # https://cloud.google.com/automl/docs/reference/rpc/google.cloud.automl.v1#textsnippet
    text_snippet = automl.TextSnippet(content=content, mime_type="text/plain")
    payload = automl.ExamplePayload(text_snippet=text_snippet)

    response = prediction_client.predict(name=model_full_id, payload=payload)

    for annotation_payload in response.payload:
        result = annotation_payload.display_name + annotation_payload.classification.score

    return result

# POST
@app.route("/predict", methods=['GET', 'POST'])
def predict():
    # ui testarea에서 정보 가져오기
    dump = request.form.get("dump")
    # 임시 파일로 값 저장
    if 'file' in request.files:
        file = request.files['file']
        fn = tempfile.mktemp(dir='/tmp')
        file.save(fn)
        f = open(fn)
        dump = f.read()
        f.close()

    # Dehydration
    # words = re.split(' |\.|\(|\)|\n|\r|,|\"', dump)
    # dehydrated_words = []
    # for word in words:
    #     if word != '' and word.find('java:') == -1 and word != 'at' and word != 'java' and word != 'com' and word != 'org':
    #         # print(word)
    #         dehydrated_words.append(word)
    
    jsonData = json.loads(dump)
    
    for key in jsonData.keys():
            if key != 'created':
                thread = jsonData[key]
                stack = '\n'.join(thread['stack'])
                file_st = open('dumps/threads/{0:07d}.txt'.format(idx), 'w')
                idx = idx + 1
                file_st.write(stack)
                file_st.close()
                # thread의 이름에서 영어, 띄워쓰기만 남기고 나머지(숫자, 기호 등) 삭제 
                name = re.sub('[^ a-zA-Z]','',thread['name'])
                stack = re.sub('^\"[^\"]*\"', name, stack)
                
                #스레드의 고유번호(#1234), 포인터 저장 위치(형식 [0x000], <0x000>) 삭제
                stack = re.sub('#[0-9]+|\[[^)]*?\]|\<[^)]*?\>', '', stack)
                
                #공백, .(온점), (, ), ,(반점) 기준으로 split
                words = re.split(' |\.|\(|\)|\n|,', stack)
                
                dehydrated_words = []
                for word in words:
                    #비워있는 word 스킵
                    if word == '' : continue
                    
                    #java: 형식으로 되어있는 코드 행 삭제, prio=, os_prio, tid, nid 가 포함된 단어 삭제
                    #javax, at, java, com, org 처럼 의미없이 자주 출현하는 단어 삭제(불용어 처리)
                    if word.find('java:') == -1 and word.find('prio=') == -1 and word.find('id=') == -1 and \
                    word != 'javax' and word != 'at' and word != 'java' and word != 'com' and word != 'org':
                        dehydrated_words.append(word)

    content = ' '.join(dehydrated_words)
    print(dehydrated_words, flush=True)

    # autoML Service Client 불러오기
    prediction_client = automl.PredictionServiceClient()

    # Get the full path of the model.
    model_full_id = automl.AutoMlClient.model_path(project_id, "us-central1", model_id)

    # Supported mime_types: 'text/plain', 'text/html'
    # https://cloud.google.com/automl/docs/reference/rpc/google.cloud.automl.v1#textsnippet
    text_snippet = automl.TextSnippet(content=content, mime_type="text/plain")
    payload = automl.ExamplePayload(text_snippet=text_snippet)

    response = prediction_client.predict(name=model_full_id, payload=payload)

    result = "<pre>"
    for annotation_payload in response.payload:
        result = result + u"Predicted class name: {}<br>".format(annotation_payload.display_name) \
                 + u"Predicted class score: {}<br>".format(annotation_payload.classification.score)
    result = result + "</pre>"

    return result, 200


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)

