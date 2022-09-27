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

</style>
