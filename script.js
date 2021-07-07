function PopupCenter(url, title, w, h) {
    // Fixes dual-screen position                         Most browsers      Firefox  
    var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
    var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;

    width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
    height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

    var left = ((width / 2) - (w / 2)) + dualScreenLeft;
    var top = ((height / 2) - (h / 2)) + dualScreenTop;
    var newWindow = window.open(url, title, 'resizable=0, scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

    // Puts focus on the newWindow  
    if (window.focus) {
        newWindow.focus();
    }
}


//valentines update
var HeartsBackground = {
    heartHeight: 60,
    heartWidth: 64,
    hearts: [],
    heartImage: 'loader/heart.png',
    maxHearts: 6,
    minScale: 0.4,
    draw: function () {
        this.setCanvasSize();
        this.ctx.clearRect(0, 0, this.w, this.h);
        for (var i = 0; i < this.hearts.length; i++) {
            var heart = this.hearts[i];
            heart.image = new Image();
            heart.image.style.height = heart.height;
            heart.image.src = this.heartImage;
            this.ctx.globalAlpha = heart.opacity;
            this.ctx.drawImage(heart.image, heart.x, heart.y, heart.width, heart.height);
        }
        this.move();
    },
    move: function () {
        for (var b = 0; b < this.hearts.length; b++) {
            var heart = this.hearts[b];
            heart.y += heart.ys;
            if (heart.y > this.h) {
                heart.x = Math.random() * this.w;
                heart.y = -1 * this.heartHeight;
            }
        }
    },
    setCanvasSize: function () {
        this.canvas.width = window.innerWidth;
        this.canvas.height = window.innerHeight;
        this.w = this.canvas.width;
        this.h = this.canvas.height;
    },
    initialize: function () {
        this.canvas = $('#canvas')[0];
        if (!this.canvas.getContext)
            return;

        this.setCanvasSize();
        this.ctx = this.canvas.getContext('2d');

        for (var a = 0; a < this.maxHearts; a++) {
            var scale = (Math.random() * (1 - this.minScale)) + this.minScale;
            this.hearts.push({
                x: Math.random() * this.w,
                y: Math.random() * this.h,
                ys: Math.random() + 1,
                height: scale * this.heartHeight,
                width: scale * this.heartWidth,
                opacity: scale
            });
        }

        setInterval($.proxy(this.draw, this), 30);
    }
};

//christmas update
// $(document).snowfall({
//     flakeCount : 120, 
//     // flakeColor: '#ddd',
//     // flakeIndex: '1',
//     minSpeed : 1, 
//     maxSpeed : 2.4, 
//     minSpeed: 2,
//     maxSize : 7,
//     round: true,
//     // shadow: true,
// });

//valentines update
// $(document).snowfall({
//     flakeCount : 4,
//     minSize : 10, 
//     maxSize : 42,
//     image: "loader/heart-beat.gif",
// });


//setInterval(function () {
//    location.reload();
//}, 15 * 60 * 1000);