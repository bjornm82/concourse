package cmd

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/gorilla/mux"
	"github.com/spf13/cobra"
)

// serveCmd represents the serve command
var serveCmd = &cobra.Command{
	Use:   "serve",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		host, ok := os.LookupEnv("HTTP_SERVER_HOST")
		if ok != true {
			log.Fatal("host not found")
		}
		port, ok := os.LookupEnv("HTTP_SERVER_PORT")
		if ok != true {
			log.Fatal("port not found")
		}

		r := mux.NewRouter()
		r.HandleFunc("/", HomeHandler)
		http.Handle("/", r)
		srv := &http.Server{
			Handler: r,
			Addr:    fmt.Sprintf("%s:%s", host, port),
			// Good practice: enforce timeouts for servers you create!
			WriteTimeout: 15 * time.Second,
			ReadTimeout:  15 * time.Second,
		}

		log.Println("serving...")
		log.Fatal(srv.ListenAndServe())
	},
}

// HomeHandler handles root
func HomeHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(200)
	log.Println("request made to /")
	w.Write([]byte("{\"message\": \"ok\"}"))
}

func init() {
	rootCmd.AddCommand(serveCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// serveCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// serveCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
