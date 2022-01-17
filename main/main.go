package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"math/rand"
	"os"
	"strconv"
	"strings"

	_ "github.com/lib/pq"
)

type Conf struct {
	Host     string `json:"host"`
	Port     int    `json:"port"`
	User     string `json: "user"`
	Password string `json:"password"`
	Dbname   string `json: "dbname"`
}

type Question struct {
	QuestionInfos []QuestionInfo `json:"Questions"`
}

type QuestionInfo struct {
	Title   string `json:"Title"`
	Content string `json:"body"`
	ID      int    `json: "id"`
}

type Answer struct {
	AnswerInfos []AnswerInfo `json:"Answers"`
}

type AnswerInfo struct {
	Content  string `json:"body"`
	Parentid int    `json: "parentid"`
	ID       int    `json: "id"`
}

type User struct {
	UserInfos []UserInfo `json:"users"`
}

type UserInfo struct {
	name string `json:"Name"`
}

type Tags struct {
	TagsInfos []TagsInfo `json:"Tags"`
}

type TagsInfo struct {
	Name string `json:"TagName"`
	ID   int    `json: "Id"`
}

func main() {
	confJsonFile, err := os.Open("conf.json")
	if err != nil {
		panic(err)
	}

	defer confJsonFile.Close()
	var Conf Conf
	ConfVaule, _ := ioutil.ReadAll(confJsonFile)
	json.Unmarshal(ConfVaule, &Conf)
	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s "+"password=%s dbname=%s sslmode=disable", Conf.Host, Conf.Port, Conf.User, Conf.Password, Conf.Dbname)
	db, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		panic(err)
	}

	defer db.Close()

	UserJsonFile, err := os.Open("UserDetails.json")
	if err != nil {
		panic(err)
	}

	defer UserJsonFile.Close()
	var User User
	UserVaule, err := ioutil.ReadAll(UserJsonFile)
	json.Unmarshal(UserVaule, &User)
	if err != nil {
		panic(err)
	}
	UserInsertSql := `INSERT INTO "User" VALUES ($1, $2, $3)`
	for i := 1; i < len(User.UserInfos); i++ {
		_, err = db.Exec(UserInsertSql, i, User.UserInfos[i].name, strings.ToLower(strings.ReplaceAll(User.UserInfos[i].name, " ", ""))+"@buffalo.edu")
		if err != nil {
			panic(err)
		}
	}
	_, err = db.Exec(UserInsertSql, 5001, "Sai Prashanth", "saiprash@buffalo.edu")
	if err != nil {
		panic(err)
	}

	communityInsertSql := `INSERT INTO Community ("Community_id", "Name", "type", "Created_by") VALUES ($1, $2, $3, $4)`
	_, err = db.Exec(communityInsertSql, 2, "StackOverflow", "Public", 5001)
	if err != nil {
		panic(err)
	}
	communityMemberCreateSql := `INSERT INTO "Community Member" ("CM_id", "User_id", "Community_id", "Reputation", "Badge Count", "isAdmin", "isRemoved") VALUES ($1, $2, $3, $4, $5, $6, $7)`
	for i := 1; i < 5000; i++ {
		_, err = db.Exec(communityMemberCreateSql, i, i, 2, 200, 0, false, false)
		if err != nil {
			panic(err)
		}
	}

	tagJsonFile, err := os.Open("TagResults.json")
	if err != nil {
		panic(err)
	}

	defer tagJsonFile.Close()
	var Tags Tags
	tagValue, _ := ioutil.ReadAll(tagJsonFile)
	json.Unmarshal(tagValue, &Tags)
	TagCreateSql := `INSERT INTO public.Tag ("Tag_id", "Name", "Description", "Created_by", "Community_id") VALUES ($1, $2, $3, $4, $5)`
	for i := 0; i < len(Tags.TagsInfos); i++ {
		randTagUser := rand.Intn(4000) + 1
		_, err = db.Exec(TagCreateSql, i+1, Tags.TagsInfos[i].Name, Tags.TagsInfos[i].Name, randTagUser, 2)
		if err != nil {
			fmt.Printf(TagCreateSql, i+1, Tags.TagsInfos[i].Name, Tags.TagsInfos[i].Name, randTagUser, 2)
			panic(err)

		}
	}

	questionJsonFile, err := os.Open("QuestionDetails.json")
	if err != nil {
		panic(err)
	}

	defer questionJsonFile.Close()
	var Questions Question
	byteValue, _ := ioutil.ReadAll(questionJsonFile)
	json.Unmarshal(byteValue, &Questions)

	postCreateSql := `INSERT INTO Post ("Post_id", "Created_by") VALUES ($1, $2)`
	QuestionCreateSql := `INSERT INTO public.Question ("Question_id", "Protected?", "Reviewed") VALUES ($1, $2, $3)`
	questionVersionCreateSql := `INSERT INTO public."Question Version" ("Version_id", "Question_id", "Title", "Content", "Version_Created_by") VALUES ($1, $2, $3, $4, $5)`

	ReviewCreateSql := `INSERT INTO public.Review ("Review_id", "Type", "Reviewed_by", "Post_id") VALUES ($1, $2, $3,$4)`

	TaggedQuestionCreateSql := `INSERT INTO public."Tagged Question" ("id", "Tag_id", "Version_id") VALUES ($1, $2, $3)`

	for i := 0; i < len(Questions.QuestionInfos); i++ {
		randReviewUser := rand.Intn(4000) + 1

		_, err = db.Exec(postCreateSql, Questions.QuestionInfos[i].ID, i+1)
		if err != nil {
			panic(err)
		}
		_, err = db.Exec(QuestionCreateSql, Questions.QuestionInfos[i].ID, false, "Accepted")
		if err != nil {
			panic(err)
		}
		_, err = db.Exec(questionVersionCreateSql, Questions.QuestionInfos[i].ID, Questions.QuestionInfos[i].ID, Questions.QuestionInfos[i].Title, Questions.QuestionInfos[i].Content, i+1)
		if err != nil {
			panic(err)
		}
		_, err = db.Exec(ReviewCreateSql, i+1, "Accepted", randReviewUser, Questions.QuestionInfos[i].ID)
		if err != nil {
			panic(err)
		}

		for j := 0; j < 4; j++ {
			randTagId := rand.Intn(999) + 1
			_, err = db.Exec(TaggedQuestionCreateSql, (i+1)*10+j, randTagId, Questions.QuestionInfos[i].ID)
			if err != nil {
				panic(err)
			}
		}

	}

	answerJsonFile, err := os.Open("AnswerDetails.json")
	if err != nil {
		panic(err)
	}
	defer answerJsonFile.Close()
	var Answers Answer
	answerByteValue, _ := ioutil.ReadAll(answerJsonFile)
	json.Unmarshal(answerByteValue, &Answers)
	accepted := false
	AnswerCreateSql := `INSERT INTO public.Answer ("Answer_id", "Accepted", "Question_id") VALUES ($1, $2, $3)`
	AnswerVersionCreateSql := `INSERT INTO public."Answer Version" ("Version_id", "Answer_id", "Content", "Version_Created_by") VALUES ($1, $2, $3, $4)`

	CommentCreateSql := `INSERT INTO public.Comment ("Comment_id","Answer_id") VALUES ($1, $2)`
	CommentVersionCreateSql := `INSERT INTO public."Comment Version" ("Version_id", "Comment_id", "Content", "Version_Created_by") VALUES ($1, $2, $3, $4)`

	VoteCreateSql := `INSERT INTO public.Vote ("id", "Vote_type", "Voted_by", "Voted_post") VALUES ($1, $2, $3, $4)`

	for i := 0; i < len(Answers.AnswerInfos); i++ {
		log.Printf("Inside answer loop", i)
		if Answers.AnswerInfos[i].Parentid > 0 {
			randAnsUser := rand.Intn(4000) + 1
			randCommentUser := rand.Intn(4000) + 1
			_, err = db.Exec(postCreateSql, Answers.AnswerInfos[i].ID, randAnsUser)
			if err != nil {
				continue
			}
			if i%10 == 0 {
				accepted = true
			} else {
				accepted = false
			}

			_, err = db.Exec(AnswerCreateSql, Answers.AnswerInfos[i].ID, accepted, Answers.AnswerInfos[i].Parentid)
			if err != nil {
				fmt.Println(AnswerCreateSql, Answers.AnswerInfos[i].ID, accepted, Answers.AnswerInfos[i].Parentid)
				panic(err)
			}
			_, err = db.Exec(AnswerVersionCreateSql, Answers.AnswerInfos[i].ID, Answers.AnswerInfos[i].ID, Answers.AnswerInfos[i].Content, randAnsUser)
			if err != nil {
				panic(err)
			}

			//5 Vote for every answers
			for j := 1; j <= 5; j++ {
				_, err = db.Exec(VoteCreateSql, (i+1)*10+j, "Up", randCommentUser, Answers.AnswerInfos[i].ID)
				if err != nil {
					panic(err)
				}
			}

			for j := 1; j <= 5; j++ {
				randUser := rand.Intn(3000) + 1
				_, err = db.Exec(postCreateSql, (i+1)*10000+j*2, randUser)
				if err != nil {
					panic(err)
				}
				_, err = db.Exec(CommentCreateSql, (i+1)*10000+j*2, Answers.AnswerInfos[i].ID)
				if err != nil {
					panic(err)
				}
				_, err = db.Exec(CommentVersionCreateSql, (i+1)*10000+j*2, (i+1)*10000+j*2, "This is a script generated comment for ID: "+strconv.Itoa(Answers.AnswerInfos[i].ID), randUser)
				if err != nil {
					panic(err)
				}

			}
		}

	}
}
