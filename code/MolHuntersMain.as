package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;

	import br.cefetmg.inf.molhunters.Mario;

	public class MolHuntersMain extends MovieClip {

		//	The acceleration of the fall.
		var gravity: Number = 1;

		//  The fastest the mario will be able to fall
		var maxGravity: Number = 20;

		//	Determinds whether mario or background moves.
		var sideScrollingMode: Boolean = true;

		//	importing movieclips:
		var mario: Mario = new Mario;
		var plataformas: Plataformas = new Plataformas;

		public function MolHuntersMain() {
			gotoAndStop(1, "Tela_Jogo");
			createGame();
		}

		/*
		private function onBtPlayClick(e: MouseEvent) {

			gotoAndStop(1, "Tela_Jogo");
			
		}
		*/

		private function createGame() {

			addChild(plataformas);
			addChild(mario);

			mario.x = stage.stageWidth / 2;
			mario.y = stage.stageHeight / 1.5;

			plataformas.x = stage.stageWidth / 2;
			plataformas.y = stage.stageHeight / 1.2

			plataformas.restart_mc.visible = false;

			stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}

		private function onEnterFrameHandler(e: Event) {

			onEnterFrame(mario);

			function onEnterFrame(m: MovieClip) {
				trace('chegou aq');

				if (m is Mario) {
					trace('é uma instância de Mario');
					var mc: Mario = m as Mario;
				}

				if (mc.leftPressed || mc.rightPressed || mc.upPressed || mc.downPressed || mc.spacePressed) {
					// mc.play();
				} else {
					// mc.gotoAndStop(1);
				}

				if (plataformas.hitTestPoint(mc.x, mc.y, true)) {
					mc.downBumping = true;
				} else {
					mc.downBumping = false;
				}

				if (plataformas.hitTestPoint(mc.x, mc.y - 2, true)) {
					mc.underBumping = true;
				} else {
					mc.underBumping = false;
				}

				if (plataformas.hitTestPoint(mc.x - mc.width / 2, mc.y - mc.height / 2, true)) {
					mc.leftBumping = true;
				} else {
					mc.leftBumping = false;
				}

				if (plataformas.hitTestPoint(mc.x + mc.width / 2, mc.y - mc.height / 2, true)) {
					mc.rightBumping = true;
				} else {
					mc.rightBumping = false;
				}

				if (plataformas.hitTestPoint(mc.x, mc.y - mc.height, true)) {
					mc.upBumping = true;
				} else {
					mc.upBumping = false;
				}

				if (plataformas.restart_mc.hitTestPoint(mc.x, mc.y, true)) {
					restartGame();
				}

				if (mc.rightPressed) {
					if (mc.xRight < mc.topSpeed) {
						mc.xRight += mc.acceleration;
					}
				} else {
					if (mc.xRight > 0.5) {
						mc.xRight -= mc.friction;
					} else if (mc.xRight < -0.5) {
						mc.xRight += mc.friction;
					} else {
						mc.xRight = 0;
					}
				}

				if (mc.leftPressed) {
					if (mc.xLeft < mc.topSpeed) {
						mc.xLeft += mc.acceleration;
					}
				} else {
					if (mc.xLeft > 0.5) {
						mc.xLeft -= mc.friction;
					} else if (mc.xLeft < -0.5) {
						mc.xLeft += mc.friction;
					} else {
						mc.xLeft = 0;
					}
				}

				if (mc.rightBumping) {
					if (mc.willBounce) {
						mc.xRight *= mc.bounciness;
					} else {
						mc.xRight = 0;
					}
				}

				if (mc.leftBumping) {
					if (mc.willBounce) {
						mc.xLeft *= mc.bounciness;
					} else {
						mc.xLeft = 0;
					}
				}

				if (mc.upBumping) {
					mc.posY = 1;
				}

				if (mc.downBumping) {
					mc.posY = 0;

					mc.inAir = false;
				} else {
					if (mc.posY < maxGravity) {
						mc.posY += gravity;
					}
				}

				if (mc.underBumping) {
					mc.posY = -2;
				}

				if (mc.upPressed) {
					if (mc.downBumping) {
						mc.posY = mc.FirstJumpHeight;

						mc.doubleJumpReady = false;

						mc.inAir = true;
					}

					if (mc.doubleJumpReady && mc.inAir && mc.doubleJump) {
						mc.y = mc.SecondJumpHeight;

						mc.doubleJumpReady = false;

						mc.inAir = false;
					}
				} else {
					if (mc.inAir) {
						mc.doubleJumpReady = true;
					}
				}

				if (sideScrollingMode) {
					plataformas.x -= mc.xRight;
					plataformas.x += mc.xLeft;

					plataformas.y -= mc.posY;
				} else {
					mc.x += mc.xRight;
					mc.x -= mc.xLeft;

					mc.y += mc.posY;
				}
			}
		}

		private function restartGame() {
			mario.x = stage.stageWidth / 2;
			mario.y = stage.stageHeight / 1.5;

			plataformas.x = stage.stageWidth / 2;
			plataformas.y = stage.stageHeight / 1.2
		}

		private function keyUpHandler(e: KeyboardEvent) {

			onKeyUp(mario);

			function onKeyUp(m: MovieClip) {

				if (m is Mario) {
					var mc: Mario = m as Mario;
				}

				switch (e.keyCode) {

					case 65:
						mc.leftPressed = false;
						break;
					case 37:
						mc.leftPressed = false;
						break;

					case 87:
						mc.upPressed = false;
						break;
					case 38:
						mc.upPressed = false;
						break;

					case 39:
						mc.rightPressed = false;
						break;
					case 68:
						mc.rightPressed = false;
						break;

					case 83:
						mc.downPressed = false;
						break;
					case 40:
						mc.downPressed = false;
						break;
				}
			}
		}

		private function keyDownHandler(e: KeyboardEvent) {

			onKeyDown(mario);

			function onKeyDown(m: MovieClip) {

				if (m is Mario) {
					var mc: Mario = m as Mario;
				}

				switch (e.keyCode) {

					case 65:
						mc.leftPressed = true;
						break;
					case 37:
						mc.leftPressed = true;
						break;

					case 87:
						mc.upPressed = true;
						break;
					case 38:
						mc.upPressed = true;
						break;

					case 39:
						mc.rightPressed = true;
						break;
					case 68:
						mc.rightPressed = true;
						break;

					case 83:
						mc.downPressed = true;
						break;
					case 40:
						mc.downPressed = true;
						break;
				}
			}
		}
	}
}