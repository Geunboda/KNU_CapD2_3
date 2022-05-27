from google.cloud import automl
import os
import re
import tempfile
from flask import Flask, request, Response, render_template
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


@app.route("/predict", methods=['GET', 'POST'])
def predict():
    dump = request.form.get("dump")
    if 'file' in request.files:
        file = request.files['file']
        fn = tempfile.mktemp(dir='/tmp')
        file.save(fn)
        f = open(fn)
        dump = f.read()
        f.close()

    # Dehydration
    words = re.split(' |\.|\(|\)|\n|\r|,|\"', dump)
    dehydrated_words = []
    for word in words:
        if word != '' and word.find('java:') == -1 and word != 'at' and word != 'java' and word != 'com' and word != 'org':
            # print(word)
            dehydrated_words.append(word)

    content = ' '.join(dehydrated_words)
    print(dehydrated_words, flush=True)

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
    app.run(host='0.0.0.0', port=8998)

