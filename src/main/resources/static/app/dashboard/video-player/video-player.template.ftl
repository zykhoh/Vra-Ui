<div class="container col-md-8">
    <div class="shadow">
        <video id="currentVideo" class="video-js vjs-default-skin" controls preload="none"
               data-setup='{ "aspectRatio":"640:267", "playbackRates": [1, 1.5, 2] }'>
        </video>

        <div class="panel padding-lr-32 padding-bottom-32">
            <h3>
                <b>{{ video.title }}</b>
                <span class="pull-right">{{ video.date | date:'MM/dd/yyyy'}}</span>
            </h3>

            <h5>{{ video.description }}</h5>
        </div>
    </div>
</div>
