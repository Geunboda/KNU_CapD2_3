#!/bin/sh
# -------------------------------------------------------------
#   OPENMARU APM                  http://support.opennaru.com/
#
#   contact : support@opennaru.com
#   Copyright(C) 2017, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

# /path/to/khan-agent.jar -Dkhan.config.file=khan-agent.conf 12345
#export KHAN_HOME=`pwd`

java -cp khan-agent-5.1.0.jar:$JAVA_HOME/lib/tools.jar com.opennaru.khan.agent.KhanAgentLoader $*