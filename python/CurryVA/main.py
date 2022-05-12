import speech_recognition as sr
import pyttsx3
import pywhatkit
import datetime
import wikipedia
import pyjokes
import os
import webbrowser
import json
import wolframalpha
import requests


listener = sr.Recognizer()
engine = pyttsx3.init()
voices = engine.getProperty('voices')
engine.setProperty('voice', voices[1].id)


def talk(text):
    engine.say(text)
    engine.runAndWait()


def take_command():
    try:
        with sr.Microphone() as source:
            print('listening...')
            voice = listener.listen(source)
            command = listener.recognize_google(voice)
            command = command.lower()
            if 'curry' in command:
                command = command.replace('curry', '')
                print(command)
    except:
        pass
    return command


def wishMe():
    hour=datetime.datetime.now().hour
    if hour>=0 and hour<12:
        talk("Good Morning")
        print("Good Morning")
    elif hour>=12 and hour<18:
        talk("Good Afternoon")
        print("Good Afternoon")
    else:
        talk("Good Evening")
        print("Good Evening")


def run_curry():
    command = take_command()
    print(command)
    if 'play' in command:
        song = command.replace('play', '')
        talk('playing ' + song)
        pywhatkit.playonyt(song)
    elif 'time' in command:
        time = datetime.datetime.now().strftime('%I:%M %p')
        talk('Current time is ' + time)

    elif 'who is' in command:
        person = command.replace('who is', '')
        info = wikipedia.summary(person, 1)
        print(info)
        talk(info)
    elif 'date' in command:
        talk('sorry, I have a headache')
    elif 'joke' in command:
        talk(pyjokes.get_joke())
    elif 'hello' in command:
        wishMe()
    elif 'calculate' in command:
        app_id = "Paste your unique ID here "
        client = wolframalpha.Client('EPWPX3-49GERKV5AU')
        res = client.query(take_command())
        answer = next(res.results).text
        talk(answer)
        print(answer)
    else:
        talk('Please say the command again.')


while True:
    run_curry()
