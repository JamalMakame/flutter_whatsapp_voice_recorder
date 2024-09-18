# Flutter Whatsapp Voice Recorder

A flutter project to demonstrate the Voice Recording and Playback feature of WhatsApp with Custom
Animations. The app has been built to showcase the MVVM + Clean architecture model.

-   The view is only responsible for user interaction and nothing else.
-   The ViewModel handles all the business logic for the View.
-   The Service provide all the functionality required by the ViewModel. This helps in
    decoupling the dependency and packages can be swapped easily when needed.
-   The Repository provide the Service, the methods to achieve the functionality or complete
    the request.
-   The DataStoreFactory hides all the logic for the source of the data, ie: whether it is
    coming from the local DB or remote api service.
-   A service locator is used for Dependency Injection to create all the necessary classes.

The following functionalities are supported by the recorder:

-   The recording starts on long press of the button.
-   The audio gets saved when the long press is released.
-   The audio record can be cancelled by swiping left.
-   The longer audio record can be enabled by swiping the button vertically to lock.
-   The audio list gets populated immediately when the recording is stopped.
-   The audio can be played by tapping on the card and a waveform indicator is shown to
    indicate the playing file.

<br /><br />
The demo also shows proper package mangement which is very essential for scaling and keeping the
code neat and tidy.<br />
Wherever needed, the code are converted to methods, and they are used across multiple files then
separated to common files.<br />

<br /><br />
If I had more time I would have done the following:<br />

<ul>
	<li>Animation for the mic and bin when recording is cancelled.</li>
	<li>Add a better handling for Exceptions.</li>
	<li>Include the progress indicator and timer when the audio is played.</li>
</ul>

<br /><br />
APK of the app can be found under apk folder. Here are few screenshots and screen recording to
showcase the app:
<br /><br />

List UI:
![WhatsApp Recorder List](screenshots_and_recordings/list-ui.jpg)

Recording UI:
![WhatsApp Recorder Recording UI](screenshots_and_recordings/recording-ui.jpg)

Playing UI:
![WhatsApp Recorder Playing UI](screenshots_and_recordings/playing-ui.jpg)

Demo Recording:
![WhatsApp Recorder Demo](screenshots_and_recordings/app-demo.gif)
