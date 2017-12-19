import test from 'ava'

// 基本形
test('ava動作確認', t => {
  t.pass()
})

// タイトルはなくてもいい
test(t => {
  t.pass()
})
