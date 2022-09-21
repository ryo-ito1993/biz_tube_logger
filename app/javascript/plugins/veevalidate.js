import Vue from 'vue'
import {
  ValidationProvider,
  ValidationObserver,
  extend
} from 'vee-validate'
import {
  email,
  required
} from 'vee-validate/dist/rules';

Vue.component('ValidationObserver', ValidationObserver)
Vue.component('ValidationProvider', ValidationProvider)

extend('email', {
  ...email,
  message: '{_field_}の形式で入力してください'
});

extend('required', {
  ...required,
  message: '必須の項目です'
});

extend('min', {
  validate(value, { length }) {
    return value.length >= length;
  },
  params: ['length'],
  message: '{_field_}は{length}文字以上で入力してください'
});

extend('max', {
  validate(value, { length }) {
    return value.length <= length;
  },
  params: ['length'],
  message: '{_field_}は{length}文字以下で入力してください'
});

extend('password_confirmed', {
  params: ['target'],
  validate(value, { target }) {
    return value === target;
  },
  message: 'パスワードと一致しません'
});

extend('url_format', {
  validate(value) {
    const pattern = /\b(?:https?):\/\/(?:www\.)?(?:youtube\.com|youtu\.be)\/[\w!?/+\-|:=~;.,*&@#$%()'"[\]]+/g;
    return value.match(pattern) && value.length >= 28
  },
  message: 'YouTube動画URLを正しい形式で入力してください'
});