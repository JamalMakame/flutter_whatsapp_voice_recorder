# Flutter Whatsapp Voice Recorder

A flutter project to demonstrate the Voice Recording and Playback feature of WhatsApp with Custom Animations.

The app has been built to showcase the MVVM + Clean architecture model.<br>
<ul>
<li>The view is only reponsible for user interaction and nothing else.</li>
<li>The ViewModel handles all the business logic for the View.</li>
<li>The Service provide all the functionality required by the ViewModel. This helps in decoupling the dependency and packages can be swapped easily when needed.</li>
<li>The Repository provide the Service, the methods to achieve the functionality or complete the request.</li>
<li>The DataStoreFactory hides all the logic for the source of the data, ie: whether it is coming from the local DB or remote api service.</li>
<li>A service locator is used for Dependency Injection to create all the necessary classes.</li>
</ul>

<br><br>
The following functionalties are supported by the recorder:
<ul>
<li>The recording starts on long press of the button.</li>
<li>The audio gets saved when the long press is released.</li>
<li>The audio record can be cancelled by swiping left.</li>
<li>The longer audio record can be enabled by swiping the button vertically to lock.</li>
<li>The audio list gets populated immediately when the recording is stopped.</li>
<li>The audio can be played by tapping on the card and a waveform indicator is shown to indicate the playing file.</li>
</ul>


<br><br>
The demo also shows proper package mangement which is very essential for scaling and keeping the code neat and tidy.<br>
Wherever needed, the code are converted to methods, and they are used across multiple files then separated to common files.<br>

<br><br>
If I had more time I would have done the following:<br>
<ul>
  <li>Animation for the mic and bin when recording is cancelled.</li>
  <li>Add a better handling for Exceptions.</li>
  <li>Include the progress indicator and timer when the audio is played.</li>
</ul>

<br><br>
APK of the app can be found under apk folder. Here are few screenshots and screen recording to showcase the app:
<br><br>

List UI:    
<img src="screenshots_and_recordings/list-ui.jpg" alt="WhatsApp Recorder List" width="200"/>
Recording UI:   
<img src="screenshots_and_recordings/recording-ui.jpg" alt="WhatsApp Recorder Recording UI" width="200"/>
<br><br>

Playing UI:   
<img src="screenshots_and_recordings/playing-ui.jpg" alt="WhatsApp Recorder Playing UI" width="200"/>
Demo Recording: 
<img src="screenshots_and_recordings/app-demo.gif" alt="WhatsApp Recorder Demo" width="200"/>