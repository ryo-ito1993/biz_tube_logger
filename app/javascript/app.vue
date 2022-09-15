<template>
  <v-app>
    <TheHeader />
    <v-main class="grey lighten-4 accent-1">
      <router-view />
    </v-main>
    <TheFooter />
  </v-app>
</template>

<script>
import TheHeader from "components/TheHeader"
import TheFooter from "components/TheFooter"

export default {
  components: {
    TheHeader,
    TheFooter
  }
}
</script>

<style scoped>

</style>
