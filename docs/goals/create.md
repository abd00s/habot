### URL

```
/goals
```

### Method

```
POST
```

### Parameters

```

{
  "goal": {
    "frequency": "3",
    "period": "week",
    "title": "test goal",
    "user_id": "229"
  }
}
```

### Success Response

#### Status

201

#### Body

```
{
  "id": 132,
  "user_id": 229,
  "title": "test goal",
  "frequency": 3,
  "period": "week",
  "created_at": "2019-04-11T17:51:12.000Z",
  "updated_at": "2019-04-11T17:51:12.000Z"
}
```
