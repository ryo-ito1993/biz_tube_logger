<template>
      <v-card>
        <v-card-title class="text-h5">
          どうもどうもどうも
        </v-card-title>

        <v-card-text>
          ヤッホー
          <p>{{output}}</p>
          <p>{{youtube_id}}</p>
          <textarea v-model="output.summary"></textarea>
        </v-card-text>

        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn
            color="green darken-1"
            text
            @click="handleCloseModal"
          >
            Disagree
          </v-btn>

          <v-btn
            color="green darken-1"
            text
            @click="handleCloseModal"
          >
            Agree
          </v-btn>
        </v-card-actions>
      </v-card>
</template>

<script>
  export default {
    name: "EditModal",
    props: {
      output: {
        summary: {
          type: Text,
          required: true
        },
        impression: {
          type:Text,
          required: true
        }
      },
      youtube_id:{
        type: String,
        required: true
      }

    },
    methods: {
      handleCloseModal(){
        this.$emit('close-modal')
      }
    }
  }
</script>