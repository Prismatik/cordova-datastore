Datastore = ->
  @init = (name, cb) =>
    @db = window.sqlitePlugin.openDatabase name: "#{name}.db"
    @db.transaction (tx) ->
      tx.executeSql 'CREATE TABLE IF NOT EXISTS kv (k text primary key, v text)', [], ->
        cb()
    , cb

  @setItem = (k, v, cb) =>
    @db.transaction (tx) ->
      tx.executeSql "INSERT OR REPLACE INTO kv (k, v) VALUES (?, ?)", [k, v], ->
        cb()
    , cb

  @getItem = (k, cb) =>
    @db.transaction (tx) ->
      tx.executeSql "SELECT v FROM kv WHERE k = \"#{k}\"", [], (_, results) ->
        return cb null, null if results.rows.length is 0
        cb null, results.rows.item(0).v
      , cb

  @removeItem = (k, cb) =>
    @db.transaction (tx) ->
      tx.executeSql "DELETE FROM kv WHERE k = \"#{k}\"", [], ->
        cb()
    , cb

  @clear = (cb) ->
    @db.transaction (tx) ->
      tx.executeSql "DELETE * FROM kv", [], ->
        cb()
    , cb

  return this

module.exports = ->
  return new Datastore()
