<template>
<section>
  <div>
    HELLO  UKEY : {{ user.value }}
  </div>
    <div>
      <button @click="resetcookie">RESET</button>
    
  </div>
    
</section>
</template>

<script setup>
const user = useCookie('user')
console.log("before set cookie",user.value);
user.value = user.value ||  {ukey :"000000", uid:"xxxxxxxxx"}
console.log("set cookie",user.value);


const { data ,refresh } = await useFetch('/api/ukey',{params: {ukey:user.value.ukey,uid:user.value.uid}, pick:['ukey','uid']})
    .then( (resp) => {
     //console.log("RESP",resp,user.value,resp.data._value);
     // user.value = {ukey:resp.data._value.ukey,uid:resp.data._value.uid}
     user.value = resp.data._value;
      return resp;
    })

const resetcookie = () => {
  console.log("before reset cookie",user.value);
  user.value = {ukey :"000000", uid:"xxxxxxxxx"}
  console.log("reset cookie",user.value);
 }                

</script>