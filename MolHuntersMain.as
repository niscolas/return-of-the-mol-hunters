package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	
	public class MolHuntersMain extends MovieClip {
		
		//	importing movieclips:
		var player:player_mc = new player_mc;
		var collisions:collisions_mc = new collisions_mc;

		//// player settings (have a good play around with these to get the effects you want):
		// This is the fastest the player will be able to go
		var player_topSpeed:Number = 10;				

		// The speed that the player speeds up
		var player_acceleration:Number = 0.4;			

		// The speed that the player slows down once key is let go
		var player_friction:Number = 0.8;				

		// The first jump height
		var player_1stJumpHeight:Number = -12;			

		// If player_doubleJump is true, this will be height of second jump
		var player_2ndJumpHeight:Number = -10;			

		//	The acceleration of the fall.
		var player_gravity:Number = 1;				

		//  The fastest the player will be able to fall
		var player_maxGravity:Number = 20;				

		//	Determinds whether player will double jump or not
		var player_doubleJump:Boolean = true;			

		//	Determinds whether player will bounce off the walls like a ball
		var player_bounce:Boolean = false;				

		//	How bouncy the player will be if player_bounce is true
		var player_bounciness:Number = -2;			

		//	Determinds whether player or background moves.
		var player_sideScrollingMode:Boolean = true;	

		//// other player variables:
		//  To help the calculations on the speed of player
		var player_currentSpeed:Number;					

		var player_doubleJumpReady:Boolean = false;
		var player_inAir:Boolean = false;
		var player_xRight:Number = 0;
		var player_xLeft:Number = 0;
		var player_y:Number = 0;


		// collisions of the player:
		var downBumping, leftBumping, upBumping, rightBumping, underBumping:Boolean = false;

		//	keys pressed (this icludes the WASD keys):
		var leftPressed, rightPressed, upPressed, downPressed, spacePressed, shiftPressed:Boolean = false;

		public function MolHuntersMain() {
			gotoAndStop(1, "Tela_Jogo");
			
			createGame();
		}

		private function createGame() {

			addChild(collisions);
			addChild(player);

			player.x = stage.stageWidth/2;
			player.y = stage.stageHeight/1.5;

			collisions.x = stage.stageWidth/2;
			collisions.y = stage.stageHeight/1.2

			collisions.restart_mc.visible = false;

			stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}

		private function onEnterFrameHandler (e:Event) {

			if (collisions.hitTestPoint(player.x, player.y, true)) {
				downBumping = true;
			} else {
				downBumping = false;
			}

			if (collisions.hitTestPoint(player.x, player.y - 2, true)) {
				underBumping = true;
			} else {
				underBumping = false;
			}

			if (collisions.hitTestPoint(player.x - player.width/2, player.y - player.height/2, true)) {
				leftBumping = true;
			} else {
				leftBumping = false;
			}

			if (collisions.hitTestPoint(player.x + player.width/2, player.y - player.height/2, true)) {
				rightBumping = true;
			} else {
				rightBumping = false;
			}

			if (collisions.hitTestPoint(player.x, player.y - player.height, true)) {
				upBumping = true;
			} else {
				upBumping = false;
			}

			if (collisions.restart_mc.hitTestPoint(player.x, player.y, true)) {
				restartGame();
			}
			
			if (rightPressed) {
				if (player_xRight < player_topSpeed) {
					player_xRight += player_acceleration;
				}
			} else {
				if (player_xRight > 0.5) {
					player_xRight -= player_friction;
				} else if (player_xRight < -0.5) {
					player_xRight += player_friction;
				} else {
					player_xRight = 0;
				}
			}
			
			if (leftPressed) {
				if (player_xLeft < player_topSpeed) {
					player_xLeft += player_acceleration;
				}
			} else {
				if (player_xLeft > 0.5) {
					player_xLeft -= player_friction;
				} else if (player_xLeft < -0.5) {
					player_xLeft += player_friction;
				} else {
					player_xLeft = 0;
				}
			}			
			
			if (rightBumping) {
				if (player_bounce) {
					player_xRight *=  player_bounciness;
				} else {
					player_xRight = 0;
				}
			}

			if (leftBumping) {
				if (player_bounce) {
					player_xLeft *=  player_bounciness;
				} else {
					player_xLeft = 0;
				}
			}

			if (upBumping) {
				player_y = 1;
			}

			if (downBumping) {
				player_y = 0;
				
				player_inAir = false;
			} else {
				if (player_y < player_maxGravity) {
					player_y += player_gravity;
				}
				
			}

			if (underBumping) {
				player_y = -2;
			}
			
			if (upPressed) {
				if (downBumping) {
					player_y = player_1stJumpHeight;

					player_doubleJumpReady = false;

					player_inAir = true;
				}
				if (player_doubleJumpReady && player_inAir && player_doubleJump) {
					player_y = player_2ndJumpHeight;

					player_doubleJumpReady = false;

					player_inAir = false;
				}
			} else {
				if (player_inAir) {
					player_doubleJumpReady = true;
				}
			}
			
			if (player_sideScrollingMode) {
				collisions.x -= player_xRight;
				collisions.x += player_xLeft;

				collisions.y -= player_y;
			} else {
				player.x += player_xRight;
				player.x -= player_xLeft;

				player.y += player_y;
			}
		}

		private function restartGame() {
			player.x = stage.stageWidth/2;
			player.y = stage.stageHeight/1.5;

			collisions.x = stage.stageWidth/2;
			collisions.y = stage.stageHeight/1.2
		}

		private function keyUpHandler (e:KeyboardEvent) {

			switch(e.keyCode) {
				case 65: 
					leftPressed = false; 
					break;

				case 37: 
					leftPressed = false; 
					break;

				case 87: 
					upPressed = false; 
					break;

				case 38: 
					upPressed = false; 
					break;

				case 39: 
					rightPressed = false; 
					break;

				case 68: 
					rightPressed = false; 
					break;

				case 83: 
					downPressed = false; 
					break;

				case 40: 
					downPressed = false; 
					break;
			}
		}

		private function keyDownHandler (e:KeyboardEvent) {
			switch(e.keyCode) {
				case 65: 
					leftPressed = true; 
					break;

				case 37: 
					leftPressed = true; 
					break;

				case 87: 
					upPressed = true; 
					break;

				case 38: 
					upPressed = true; 
					break;

				case 39: 
					rightPressed = true; 
					break;

				case 68: 
					rightPressed = true; 
					break;

				case 83: 
					downPressed = true; 
					break;

				case 40: 
					downPressed = true; 
					break;

			}
		}
	}
}