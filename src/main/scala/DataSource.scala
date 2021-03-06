package org.template.ecommercerecommendation

import io.prediction.controller.PDataSource
import io.prediction.controller.EmptyEvaluationInfo
import io.prediction.controller.EmptyActualResult
import io.prediction.controller.Params
import io.prediction.data.storage.Event
import io.prediction.data.store.PEventStore

import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.rdd.RDD

import grizzled.slf4j.Logger

case class DataSourceParams(appName: String) extends Params

class DataSource(val dsp: DataSourceParams)
  extends PDataSource[TrainingData,
      EmptyEvaluationInfo, Query, EmptyActualResult] {

  @transient lazy val logger = Logger[this.type]

  override
  def readTraining(sc: SparkContext): TrainingData = {

    // create a RDD of (entityID, User)
    val sqlContext = new org.apache.spark.sql.SQLContext(sc)

    import sqlContext.implicits._

    val usersRDD: RDD[(String, User)] = sqlContext.jsonFile("s3n://luxola-ml/bigquery/abs/users.json.gz").map { case (u) =>
      val user = try {
        User()
      } catch {
        case e: Exception => {
          logger.error(s"Exception: ${e}.")
          throw e
        }
      }
      (u(0).toString, user)
    }.cache()

    // create a RDD of (entityID, Item)
    val itemsRDD: RDD[(String, Item)] = sqlContext.jsonFile("s3n://luxola-ml/bigquery/abs/products.json.gz").map { case (p) =>
      val item = try {
        val categories: List[String] = p(1).toString.split(",").map(_.trim).toList
        Item(categories = Option(categories), account = p(2).toString, hidden = (p(3) == true))
      } catch {
        case e: Exception => {
          logger.error(s"Exception: ${e}.")
          throw e
        }
      }
      (p(0).toString, item)
    }.cache()

    val viewEventsRDD: RDD[ViewEvent] = sqlContext.jsonFile("s3n://luxola-ml/bigquery/abs/views.json.gz").map { case v =>
      try {
        ViewEvent(
          user = v(0).toString,
          item = v(1).toString,
          t = v(2).toString.toLong
        )
      } catch {
        case e: Exception => {
          logger.error(s"Exception: ${e}.")
          throw e
        }
      }
    }.cache()

    val buyEventsRDD: RDD[BuyEvent] = sqlContext.jsonFile("s3n://luxola-ml/bigquery/abs/purchases.json.gz").map { case v =>
      try {
        BuyEvent(
          user = v(0).toString,
          item = v(1).toString,
          t = v(2).toString.toLong
        )
      } catch {
        case e: Exception => {
          logger.error(s"Exception: ${e}.")
          throw e
        }
      }
    }.cache()

    new TrainingData(
      users = usersRDD,
      items = itemsRDD,
      viewEvents = viewEventsRDD,
      buyEvents = buyEventsRDD
    )
  }
}

case class User()

case class Item(categories: Option[List[String]], account: String, hidden: Boolean)

case class ViewEvent(user: String, item: String, t: Long)

case class BuyEvent(user: String, item: String, t: Long)

class TrainingData(
  val users: RDD[(String, User)],
  val items: RDD[(String, Item)],
  val viewEvents: RDD[ViewEvent],
  val buyEvents: RDD[BuyEvent]
) extends Serializable {
  override def toString = {
    s"users: [${users.count()} (${users.take(2).toList}...)]" +
    s"items: [${items.count()} (${items.take(2).toList}...)]" +
    s"viewEvents: [${viewEvents.count()}] (${viewEvents.take(2).toList}...)" +
    s"buyEvents: [${buyEvents.count()}] (${buyEvents.take(2).toList}...)"
  }
}
