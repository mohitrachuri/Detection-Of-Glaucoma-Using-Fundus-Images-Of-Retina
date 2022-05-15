# ServiceManager.sh - Autonomously restarts the web service and alerts an administrator

while [ true ] 
do
    sudo node app.js 2> error_log.txt
    exitCode=$? 
    if [ $exitCode -eq 0 ]
    then
        echo "Knowledge Grab exited cleanly."
    else
        echo "Knowledge Grab exited uncleanly."
        errorMessage=$(tail -n 4 error_log.txt)
        cat error_log.txt
        rm error_log.txt
        textContents="Knowledge Grab experienced an error. $errorMessage"
        python3 ~/Server-Setup/texting_utility.py "$textContents"
    fi
done
