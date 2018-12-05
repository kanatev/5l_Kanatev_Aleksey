//
//  main.swift
//  5l_Kanatev_Aleksey
//
//  Created by AlexMacPro on 05/12/2018.
//  Copyright © 2018 AlexMacPro. All rights reserved.
//

import Foundation


//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.

enum BodyType {
    case coupe, saloon, hatchback, cabin
}

enum BodyColor {
    case red, green, blue
}

enum SteeringWheel {
    case standard, sport
}

enum DriveType {
    case frontWheelDrive, rearWheelDrive, allWheelDrive
}

enum DoorState {
    case open, close
}

enum EngineState {
    case on, off
}


protocol Car {
    var carName: String { get }
    var wheelsAmount: Int { get }
    var bodyType: BodyType { get }
    var bodyColor: BodyColor { get }
    var steeringWheel: SteeringWheel { get }
    var windowsAmount: Int { get }
    var doorsAmount: Int { get }
    var driveType: DriveType { get }
    var doorState: DoorState { set get }
    var engineState: EngineState { set get }
}


//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).

extension Car {
    
    mutating func changeEngineState() {
        if self.engineState == .off {
            self.engineState = EngineState.on
        } else {
            self.engineState = EngineState.off
        }
    }
    
    mutating func changeDoorState() {
        if self.doorState == .close {
            self.doorState = DoorState.open
        } else {
            self.doorState = DoorState.close
        }
    }
    
}

//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.

class TrunkCar: Car {
    var carName: String
    var wheelsAmount: Int // реализуем протокольные свойства
    var bodyType: BodyType
    var bodyColor: BodyColor
    var steeringWheel: SteeringWheel
    var windowsAmount: Int
    var doorsAmount: Int
    var driveType: DriveType
    var doorState: DoorState = .close // задаем значения по умолчанию
    var engineState: EngineState = .off // задаем значения по умолчанию
    
    var cargoCapacity: Int // реализуем индивидуальные свойства класса
    var cargoLoad: Int {
        didSet {
            if cargoLoad > cargoCapacity {
                print("Вы пытаетесь загрузить больше, чем грузовик может увезти. Введите меньшее значение.\n")
                self.cargoLoad = 0
            }
        }
    }
    
    var cargoLoadPerCent: Int { // создаем вычисляемое свойство
        get {
            return Int(Double(cargoLoad) / Double(cargoCapacity) * 100)
        }
    }
    
    
    init(carName: String, wheelsAmount: Int, bodyColor: BodyColor, windowsAmount: Int, doorsAmount: Int, driveType: DriveType, cargoCapacity: Int){
        self.carName = carName
        self.wheelsAmount = wheelsAmount
        self.bodyType = .cabin
        self.bodyColor = bodyColor
        self.steeringWheel = .standard
        self.windowsAmount = windowsAmount
        self.doorsAmount = doorsAmount
        self.driveType = driveType
        self.cargoCapacity = cargoCapacity
        self.cargoLoad = 0
    }
}


//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Свойства автомобиля \(carName): \nЦвет: \(bodyColor), \nСостояние двигателя: \(engineState), \nСостояние дверей: \(doorState), \nЗагруженность кузова: \(cargoLoadPerCent)%\n"
    }
}


//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.

class SportCar: Car {
    var carName: String
    var wheelsAmount: Int // реализуем протокольные свойства
    var bodyType: BodyType
    var bodyColor: BodyColor
    var steeringWheel: SteeringWheel
    var windowsAmount: Int
    var doorsAmount: Int
    var driveType: DriveType
    var doorState: DoorState = .close // задаем значения по умолчанию
    var engineState: EngineState = .off // задаем значения по умолчанию
    
    var maxSpeed: Int // реализуем индивидуальные свойства класса
    var currentSpeed: Int {
        didSet {
            if engineState == .off {
                print("Сначала включите двигатель спорткара. После этого вы сможете задать текущую скорость.\n")
                self.currentSpeed = 0
            } else {
                if currentSpeed > maxSpeed {
                    print("Превышение максимальной скорости спорткара. Задайте меньшую скорость.\n")
                    self.currentSpeed = 0
                }
            }
        }
    }
    var speedPerCentFromMax: Int { // создаем вычисляемое свойство
        get {
            return Int(Double(currentSpeed) / Double(maxSpeed) * 100)
        }
    }
    
    
    init(carName: String, bodyType: BodyType, bodyColor: BodyColor, steeringWheel: SteeringWheel, windowsAmount: Int, doorsAmount: Int, driveType: DriveType, maxSpeed: Int){
        self.carName = carName
        self.wheelsAmount = 4
        self.bodyType = bodyType
        self.bodyColor = bodyColor
        self.steeringWheel = steeringWheel
        self.windowsAmount = windowsAmount
        self.doorsAmount = doorsAmount
        self.driveType = driveType
        self.maxSpeed = maxSpeed
        self.currentSpeed = 0
    }
}


//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Свойства автомобиля \(carName): \nЦвет: \(bodyColor), \nСостояние двигателя: \(engineState), \nСостояние дверей: \(doorState), \nТекущая скорость составляет \(currentSpeed) км/ч, \nэто \(speedPerCentFromMax)% от возможной скорости.\n"
    }
}


//5. Создать несколько объектов каждого класса. Применить к ним различные действия.

var trunkCarOne = TrunkCar(carName: "TrunkCar1", wheelsAmount: 6, bodyColor: .green, windowsAmount: 3, doorsAmount: 2, driveType: .allWheelDrive, cargoCapacity: 17000)

var trunkCarTwo = TrunkCar(carName: "TrunkCar2", wheelsAmount: 12, bodyColor: .red, windowsAmount: 5, doorsAmount: 4, driveType: .allWheelDrive, cargoCapacity: 10000)

var trunkCarThree = TrunkCar(carName: "TrunkCar3", wheelsAmount: 18, bodyColor: .blue, windowsAmount: 3, doorsAmount: 2, driveType: .allWheelDrive, cargoCapacity: 5000)


//5. Создать несколько объектов каждого класса. Применить к ним различные действия.

var sportCarOne = SportCar(carName: "SportCar1", bodyType: .coupe, bodyColor: .red, steeringWheel: .sport, windowsAmount: 6, doorsAmount: 2, driveType: .allWheelDrive, maxSpeed: 350)

var sportCarTwo = SportCar(carName: "SportCar2", bodyType: .hatchback, bodyColor: .green, steeringWheel: .standard, windowsAmount: 6, doorsAmount: 4, driveType: .allWheelDrive, maxSpeed: 250)

var sportCarThree = SportCar(carName: "SportCar3", bodyType: .saloon, bodyColor: .blue, steeringWheel: .sport, windowsAmount: 6, doorsAmount: 2, driveType: .allWheelDrive, maxSpeed: 400)


//6. Вывести сами объекты в консоль.

print(trunkCarOne)

trunkCarOne.cargoLoad = 20000

trunkCarOne.changeEngineState()

trunkCarOne.changeDoorState()

trunkCarOne.bodyColor = .red

trunkCarOne.cargoLoad = 8700

print(trunkCarOne)

trunkCarOne.changeEngineState()

trunkCarOne.changeDoorState()

trunkCarOne.bodyColor = .blue

trunkCarOne.cargoLoad = 13400

print(trunkCarOne)

trunkCarTwo.cargoLoad = 2000

trunkCarTwo.changeEngineState()

trunkCarTwo.changeDoorState()

print(trunkCarTwo)

trunkCarThree.cargoLoad = 5000

print(trunkCarThree)


//6. Вывести сами объекты в консоль.
print(sportCarOne)

sportCarOne.currentSpeed = 500

sportCarOne.changeEngineState()

sportCarOne.currentSpeed = 500

sportCarOne.currentSpeed = 300

print(sportCarOne)

sportCarTwo.changeEngineState()

sportCarTwo.currentSpeed = 150

sportCarTwo.changeDoorState()

print(sportCarTwo)

sportCarThree.changeEngineState()

sportCarThree.currentSpeed = 400

print(sportCarThree)
