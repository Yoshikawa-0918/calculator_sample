//
//  ContentView.swift
//  calculator_sample
//
//  Created by 吉川楓馬 on 2024/01/20.
//

import SwiftUI

struct ContentView: View {
    @State var display = "0"    //現在入力されている式を表示する変数
    @State var calcResult = "" //計算結果を保持する変数
    @State var operand = ""     //選択された演算子を保持する変数
    @State var first = 0        //１つ目の値を保持する変数
    @State var second = 0       //2つ目の値を保持する変数
    //Buttonで使う文字列の二重配列
    let inputItems = [["7","8","9","÷"],
                      ["4","5","6","×"],
                      ["1","2","3","-"],
                      ["0","AC","=","+"]]
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()   //SafeAreaを無視して背景を黒にする
            VStack {
                Spacer()
                Text(display)    //入力した数字/演算子を表示するText
                    .font(.system(size: 50))
                    .foregroundStyle(.white)
                    .frame(width: 350,alignment: .trailing)
                Text(calcResult)    //計算結果を表示するText
                    .font(.system(size: 70))
                    .foregroundStyle(.white)
                    .frame(width: 350,alignment: .trailing)
                Spacer()
                ForEach(0..<4){row in
                    HStack{
                        ForEach(0..<4){col in
                            if col == 3 {
                                //演算子のボタンはオレンジ色にする
                                Button(action: {
                                        calculation(inputItems[row][col])
                                }, label: {
                                    Text(inputItems[row][col])
                                        .font(.system(size: 35))
                                        .frame(width: 70,height: 70)
                                        .foregroundStyle(.white)
                                        .background(.orange)
                                        .clipShape(Circle())
                                })
                                .padding(5)
                            }else{
                                //演算子以外のボタンは灰色にする
                                Button(action: {
                                        calculation(inputItems[row][col])
                                }, label: {
                                    Text(inputItems[row][col])
                                        .font(.system(size: 35))
                                        .frame(width: 70,height: 70)
                                        .foregroundStyle(.white)
                                        .background(.gray)
                                        .clipShape(Circle())
                                })
                                .padding(5)
                            }
                        }
                    }
                }
            }
        }
    }
    func calculation(_ inputItem: String){
        if Int(inputItem) != nil {  //数値かどうか判定する
            /*
              displayが初期値のまま、または、演算子であれば書き換える
              そうでなかったら文字列を連結する
            */
            if display == "0" || Int(display) == nil {
                display = inputItem
            }else{
                display += inputItem
            }
        }else if inputItem == "AC" || inputItem == "=" {
            if inputItem == "AC" {
                display = "0"
                calcResult = ""
                operand = ""
            }else{
                if Int(display) != nil {    //displayが数値かどうかチェック
                    second = Int(display)!
                    switch operand {  //演算子ごとに処理を分ける
                    case "+":
                        calcResult = String(first + second)
                        break
                    case "-":
                        calcResult = String(first - second)
                        break
                    case "×":
                        calcResult = String(first * second)
                        break
                    case "÷":
                        calcResult = String(first / second)
                        break
                    default:
                        break;
                    }
                }
            }
        }else{
            if Int(display) != nil{   //displayが数値かどうか判定する、つまり演算子が含まれているかどうか判定している
                first = Int(display)!
                switch inputItem {  //演算子ごとに処理を分ける
                case "+":
                    display = "+"
                    operand = "+"
                    break
                case "-":
                    display = "-"
                    operand = "-"
                    break
                case "×":
                    display = "×"
                    operand = "×"
                    break
                case "÷":
                    display = "÷"
                    operand = "÷"
                    break
                default:
                    break;
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
