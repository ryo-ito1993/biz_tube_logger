<template>
  <v-app>
    <TheHeader />
    <FlashMessage />
    <v-main>
      <router-view />
    </v-main>
    <TheFooter />
  </v-app>
</template>

<script>
import TheHeader from "components/TheHeader"
import TheFooter from "components/TheFooter"
import FlashMessage from "components/FlashMessage"

export default {
  components: {
    TheHeader,
    TheFooter,
    FlashMessage
  }
}
</script>

<style scoped>
.v-main{
  background-image: linear-gradient(180deg, #E9E9E7 2%, #EFEEEC 27%, #EEEEEC 58%, #D5D4D0 94%);
}
</style>
