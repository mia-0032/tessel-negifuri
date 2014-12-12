async = require 'async'

class ServoMotor
  @PWM_FREQUENCY = 50 # Hz
  @MAX_DUTY_CYCLE = 0.125 # 2500us
  @MIN_DUTY_CYCLE = 0.025 # 500us
  constructor: (pin_name) ->
    @tessel = require 'tessel'
    @gpio = @tessel.port['GPIO']
    @gpio.pwmFrequency(ServoMotor.PWM_FREQUENCY)
    @pin = @gpio.pin[pin_name]
  move: (angle) =>
    unless 0 <= angle <= 180
      console.log "invalid angle: #{angle}"
      return false
    duty_cycle = ServoMotor.MIN_DUTY_CYCLE
    duty_cycle += (angle / 180) * (ServoMotor.MAX_DUTY_CYCLE - ServoMotor.MIN_DUTY_CYCLE)
    @pin.pwmDutyCycle(duty_cycle)
    console.log('servo angle: ' + angle)
    true

class HatyuneMiku extends ServoMotor
  @UPPER_ANGLE = 100
  @LOWER_ANGLE = 60
  constructor: (pin_name) ->
    super pin_name
    @move HatyuneMiku.LOWER_ANGLE
  doNegifuri: (repeat_count) =>
    console.log("doNegifuri repetition:#{repeat_count}")
    repeated = 0
    async.forever((callback) =>
      async.series([
        (callback) =>
          @move HatyuneMiku.UPPER_ANGLE
          setTimeout callback, 400
      ,
        (callback) =>
          @move(HatyuneMiku.LOWER_ANGLE)
          setTimeout callback, 400
      ,
        (callback) =>
          if (++repeated < repeat_count)
            callback()
      ], callback)
    ,
      (err) ->
        console.log(err)
        return false
    )
    true

miku = new HatyuneMiku('G4')

mainLoop = ->
  miku.doNegifuri 1
  setTimeout mainLoop, 5000

console.log 'Tessel negifuri started!'
setImmediate mainLoop
