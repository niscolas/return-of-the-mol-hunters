var config = {
    type: Phaser.AUTO,
    width: 800,
    height: 600,
    backgroundColor: '#7d7d7d',
    scene: {
        preload: preload,
        create: create
    }
};

var game = new Phaser.Game(config);

function preload() {
    this.load.image('mario_img', '../assets/sprites/personagens/mario/wc-velocidade_normal.png');
    this.load.spritesheet(
        'mario', 
        '../assets/sprites/personagens/mario/wc-velocidade_normal.png', 
        { 
            frameWidth: 28, 
            frameHeight: 35 
        });
}

var anim;
var sprite;

function create() {
    var walkConfig = {
        key: 'walk',
        frames: this.anims.generateFrameNumbers('mario'),
        frameRate: 8
    };

    anim = this.anims.create(walkConfig);

    sprite = this.add.sprite(400, 300, 'mario').setScale(4);

    console.log(sprite);

    sprite.anims.load('walk');

    sprite.anims.play('walk');
}