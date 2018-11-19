package br.cefetmg.inf.molhunters {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	
	public class Mario extends MovieClip {
				//// settings (have a good play around with these to get the effects you want):
		// This is the fastest the mario will be able to go
		var topSpeed: Number = 10;

		// The speed that the mario speeds up
		var acceleration: Number = 0.4;

		// The speed that the mario slows down once key is let go
		var friction: Number = 0.8;

		// The first jump height
		var firstJumpHeight: Number = -12;

		// If doubleJump is true, this will be height of second jump
		var secondJumpHeight: Number = -10;

		//	Determinds whether mario will double jump or not
		var doubleJump: Boolean = true;

		//	Determinds whether mario will bounce off the walls like a ball
		var willBounce: Boolean = false;

		//	How bouncy the mario will be if bounce is true
		var bounciness: Number = -2;

		//// other mario variables:
		//  To help the calculations on the speed of mario
		var currentSpeed: Number;

		var doubleJumpReady: Boolean = false;
		var inAir: Boolean = false;
		var xRight: Number = 0;
		var xLeft: Number = 0;
		var posY: Number = 0;

		// plataformas of the mario:
		var downBumping, leftBumping, upBumping, rightBumping, underBumping: Boolean = false;

		//	keys pressed (this icludes the WASD keys):
		var leftPressed, rightPressed, upPressed, downPressed, spacePressed, shiftPressed: Boolean = false;

		public function Mario() {
		}
	}
}